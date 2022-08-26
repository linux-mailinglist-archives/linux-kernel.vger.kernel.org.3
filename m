Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBB65A3009
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 21:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244631AbiHZTd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 15:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbiHZTdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 15:33:23 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95F1E0952
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 12:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h9WVnwndfj9Ncs3v4MSrTwteRvvjIhvNeVW+NH7bd4g=; b=ZSyTODQKMGcnl9NyDkktbrnaIA
        3emfSaArlZ+4sXqOWl9GZYo7J/oYgXrLKG/pckQM1r59OYXoizsEiQSz9eVt/7G/KauhNtMlTcjK9
        jzuvolo2fzh8Cz56Ei3ZDwi1MdY0WyHzhXwRlzAH+jaTfTjM7211tVOSuAxqlDUgKqpxCS0zStNG9
        9+3hCZk9Uv06MzEjdshcL+WUkVb+9RnAJRFM4Z/CkKT0nXhg2rqRCItrFw6w+CBeK5BQs0OMiX5fZ
        RzF1dD1yxqrowDcs9Oe7QL6zsrID/Gsy0luO5Vu3MIUkrYvVa4vay+W5DLj0Aqbnz27RAXZMm/Ewt
        YDko7gbQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oRf4O-008dka-LS;
        Fri, 26 Aug 2022 19:32:44 +0000
Date:   Fri, 26 Aug 2022 20:32:44 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        James Smart <james.smart@broadcom.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v3 1/1] nvmet-tcp: Don't kmap() pages which can't come
 from HIGHMEM
Message-ID: <Ywkf3NJQ7/8SSV+e@ZenIV>
References: <20220822142438.5954-1-fmdefrancesco@gmail.com>
 <20220822142438.5954-2-fmdefrancesco@gmail.com>
 <YwVjpTW6vWvdVQTK@ZenIV>
 <2887364.VdNmn5OnKV@opensuse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2887364.VdNmn5OnKV@opensuse>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 08:16:59PM +0200, Fabio M. De Francesco wrote:

> As you may have already read, I'm so new to kernel development that I still
> know very little about many subsystems and drivers. I am not currently
> able to tell the difference between BVEC and KVEC. I could probably try to 
> switch from one to the other (after learning from other code), however I won't 
> be able to explain in the commit message why users should better use BVEC in 
> this case.

struct kvec: pairs of form <kernel address, length>
struct bio_vec: triples of form <page, offset, length>

Either is a way to refer to a chunk of memory; the former obviously has it
already mapped (you don't get kernel addresses otherwise), the latter doesn't
need to.

iov_iter instances might be backed by different things, including
arrays of kvec (iov_iter_kvec() constructs such) and arrays of
bio_vec (iov_iter_bvec() is the constructor for those).

iov_iter primitives (copy_to_iter/copy_from_iter/copy_page_to_iter/etc.)
work with either variant - they look at the flavour and act accordingly.

ITER_BVEC ones tend to do that kmap_local_page() + copy + kunmap_local().
ITER_KVEC obviously use memcpy() for copying and that's it.

If you need e.g. to send some subranges of some pages you could kmap them,
form kvec array, make msg.msg_iter a KVEC-backed iterator over those and
feed it to sendmsg().  Or you could take a bio_vec array instead, make
msg.msg_iter a BVEC-backed iterator over that and feed to sendmsg().

The difference is, in the latter case kmap_local() will be done on demand
*inside* ->sendmsg() instance, when it gets around to copying some data
from the source and calls something like csum_and_copy_from_iter() or
whichever primitive it chooses to use.

Why bother with mapping the damn thing in the caller and having it pinned
all along whatever ->sendmsg() you end up calling?  Just give it
page/offset/length instead of address/length and let lib/iov_iter.c
do the right thing...
