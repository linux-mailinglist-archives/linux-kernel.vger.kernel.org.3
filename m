Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60EA44FF094
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 09:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbiDMHc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 03:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233431AbiDMHck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 03:32:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D025FB0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 00:30:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1332E611BE
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 07:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C545C385A4;
        Wed, 13 Apr 2022 07:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649835019;
        bh=tnsDDmAz5jCh8QzAGMRo7VrdbOtjp8Lv5iT4u54iBtY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QbJH6qYtsbwXLt8vy2i1ZR94jc4HOVOLE3f/OrrBJSh4/VjzzWvAsZdKHNjc3g5+L
         rLzWCPoDhg40J4Va02FgWnDHZY0ip3Ib6vYzwgo/snrIWP2zEhXXZa67HiiR3qpU6l
         z6r+RxPJD9L74xo+hqartNiLu60/2x4EuCdDn640VZ/x0qlAKuGhxP1/+MvFfaU+hX
         WOMTZazleoMig5cNnteiuM2oYrIV7GwLz5CzdG/B39ijHn2XX2KDCYD0KjvhDOhl6l
         ksAcAw8Lu85vg4JDI5y6JmMaZBmnGhzcKBCjMy4tcq0iRMT1ioh6/WqNZSiaXeP8pW
         rMtk6/tJ8oAWg==
Date:   Wed, 13 Apr 2022 09:30:12 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>, lkp@lists.01.org,
        lkp@intel.com, guobing.chen@intel.com, ming.a.chen@intel.com,
        frank.du@intel.com, Shuhua.Fan@intel.com, wangyang.guo@intel.com,
        Wenhuan.Huang@intel.com, jessica.ji@intel.com, shan.kang@intel.com,
        guangli.li@intel.com, tiejun.li@intel.com, yu.ma@intel.com,
        dapeng1.mi@intel.com, jiebin.sun@intel.com, gengxin.xie@intel.com,
        fan.zhao@intel.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [ovl]  30f9ef9479: BUG:kernel_NULL_pointer_dereference,address
Message-ID: <20220413073012.qwtlopbcbbkffaby@wittgenstein>
References: <20220407094023.GA13500@xsang-OptiPlex-9020>
 <20220407102605.ipstobkadq34gmzg@wittgenstein>
 <20220411090719.GA21954@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220411090719.GA21954@xsang-OptiPlex-9020>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 05:07:19PM +0800, Oliver Sang wrote:
> hi, Christian,
> 
> On Thu, Apr 07, 2022 at 12:26:05PM +0200, Christian Brauner wrote:
> > On Thu, Apr 07, 2022 at 05:40:23PM +0800, kernel test robot wrote:
> > > 
> > > 
> > > Greeting,
> > > 
> > > FYI, we noticed the following commit (built with gcc-11):
> > > 
> > > commit: 30f9ef94795008e5146f69d2eb043922a512bf85 ("ovl: support idmapped layers")
> > > https://github.com/ammarfaizi2/linux-block brauner/linux/fs.idmapped.overlayfs.v3
> > 
> > That's an old branch. :)
> > Anything that has a *.v<idx> appended is basically an old version in my
> > tree. The base branch is always the branch name without the *.v<idx>
> > suffix.
> 
> got it. so there is no need to test these *.v<idx> branches, whatever build,
> boot or function, right? If so, we will disable it.

Yeah, I maintain *.v<idx> branches around. Each time I need to send a
new version of a patchset I do:

git checkout -b base.branch.v<idx> base.branch

and then continue working on

git checkout base.branch

for the new version. :)

I try to make sure to only push base.branch to git.kernel.org once I
know it builds fine. Before that I only push to other code-hosting
platforms. One of the reasons being that I try to avoid upsetting the
various build bots. :)
