Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B1F54D069
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358266AbiFORxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358262AbiFORxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:53:36 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABE823168
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:53:34 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 84CC768AFE; Wed, 15 Jun 2022 19:53:30 +0200 (CEST)
Date:   Wed, 15 Jun 2022 19:53:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Will McVicker <willmcvicker@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Tejun Heo <tj@kernel.org>,
        kernel-team@android.com, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] sysfs: fix sysfs_kf_seq_show null pointer
 dereference
Message-ID: <20220615175330.GA26653@lst.de>
References: <20220614172401.3010509-1-willmcvicker@google.com> <YqjFPxuPO6SZuvg2@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqjFPxuPO6SZuvg2@kroah.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 07:28:31PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Jun 14, 2022 at 05:24:01PM +0000, Will McVicker wrote:
> > When the kobj->ktype is null,
> 
> How can that happen?  What in-tree code does that?

Yes, I'd be really curious how we arrived there.  I we ever end in
this case we're having a major problem, as all the sysfs files
should go through sysfs_add_file_mode_ns, which already derferences
kobj->ktype->sysfs_ops directly.  I.e. for this to happen
kobj->ktype must have been cleared on a live file, or someone
must have bypassed sysfs_add_file_mode_ns.
