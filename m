Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE97A59346F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 20:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbiHOSCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 14:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbiHOSCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 14:02:19 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4709E25C43;
        Mon, 15 Aug 2022 11:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GcrNBmy4B7oYPvzC1iQ3x9irNnquUnomstD6AlIWDjo=; b=mbnFdPKHRrDIndSjpd0B0OjzRe
        GQl31o3UikiEGn6BQe9miqqX9F802O9C06p1/OSyBKP51WOUacxGnUx7z4T6ckelwcCtMvcfR8mrK
        5hlTPVvydm+RDOa9tDO1fR4GyEKa0taddTbbOtN5/DLk48AvbH65vleCk4EEsitm3rRsQJ7GinDca
        +MVUzc6eoN087h/COD/d3Eq28QKnb/gPmfW6dDXn2WMm++zYS6VfFmA4IuYw7kJRXaJvVMKKgpTB6
        hl+hfewNBspeJQSXz/fNRpARhUvZzAJWJM8RAbwMeI7f2gU4yfGTRikkZem3Jys2K6TVQXNv/BNYI
        +TUm5M8A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oNePm-004k5t-Qd;
        Mon, 15 Aug 2022 18:02:14 +0000
Date:   Mon, 15 Aug 2022 19:02:14 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jiacheng Xu <578001344xu@gmail.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        konishi.ryusuke@gmail.com, linux-nilfs@vger.kernel.org,
        security@kernel.org
Subject: Re: KASAN: use-after-free in nilfs_mdt_destroy
Message-ID: <YvqKJppIL4lVCn9+@ZenIV>
References: <CAO4S-mficMz1mQW06EuCF+o11+mRDiCpufqVfoHkcRbQbs8kVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO4S-mficMz1mQW06EuCF+o11+mRDiCpufqVfoHkcRbQbs8kVw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 10:03:21PM +0800, Jiacheng Xu wrote:

> Patch:
> Fix this bug by moving the assignment of inode->i_private before
> security_inode_alloc.
> An ad-hoc patch is proposed:
> https://patchwork.kernel.org/project/linux-fsdevel/patch/20211011030956.2459172-1-mudongliangabcd@gmail.com/

... and that looks like utter bollocks.  Why does security_inode_alloc()
look at ->i_private?  Which LSM is involved?
