Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BE04B785B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242780AbiBOSDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 13:03:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241542AbiBOSDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 13:03:24 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1213A107DA0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 10:03:14 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id b13so873023edn.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 10:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BJ0o1LbbbPkL3ONTf+eFHsJYmd8V+bgTcEocoTANRFw=;
        b=sW/IrqynFA4NS3qFxuwjep2QjFIVuJ33y6ChTHuc6kVIXABimZ4MoSThEc+lCmAYkF
         QdBLi392Bjy1xxJne1bvdyh8kk9bvXNN5TA2zQkMu+HmuX6ov2GmhuZFc9cWapiJT90B
         OrGl5Nn8/Vi4i4T0fhwr9Lj0ubO1UeSL1sq78Q7k+i5GsyeAO0XqClla1z/wu7nGi65O
         KRlcYKptA68Jn2UTBDy52hewCJiWdvQo8DtOcj0s7RJ5yi09JHD5BUhWHzLdmz5PWAdp
         XDJPuuvcRinWOM7vqOFBGflJQ+TBI3cu38sdgeh/my2E4byQuZc6c9pSipkYqKu7oXFH
         hvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BJ0o1LbbbPkL3ONTf+eFHsJYmd8V+bgTcEocoTANRFw=;
        b=l6qdJE4IQcky97sU7W98FAaolbmzhs0Xvs+Y9GMYu6GUvv9tHJ7Hrn0ED5mU/FwjuB
         V5If2fkG4im6umlMcOU4UMFWSMee6E++bTHP1eoqjJY+Bbhbe7sHp5IFtXecTCP5BXM2
         8JCFZov+f1vimo07EALnBRH5dSQ7f3ZVjkdmHZzu0/MW2iBozAFWvQq5JAkr8P3bVMwR
         pdgm+uJaAqmI0kypaAGi1mDce9rvWY25+ClCV29ufYnUDypTWt6tAySQnT/kW7VgZ1Er
         psrlXxYzD0CWoNR7LqGWn9LSAY5Xz6dgxxPLsaHs6rLDdj5ZiNzlAFRPX5eUP3HbBNhQ
         EFiA==
X-Gm-Message-State: AOAM533ZMaalqKhOXBHUSyTOObC2Pihcsp0MItCDh1LwJqI5cL5QS7J0
        bWdIQIVN5ffmWxqjfGfPUFlwPrhFlxxGHQoTmBhTloNrSSM=
X-Google-Smtp-Source: ABdhPJzrv1k7qz2tLrhupOb2QFbnLukBkVNPs6DNVFLv+e/UrsDCFpiMzzQDBNpQf+dfSAlyaAAfxGsGDq9kgl1HFgo=
X-Received: by 2002:a05:6402:22cf:: with SMTP id dm15mr83839edb.327.1644948192404;
 Tue, 15 Feb 2022 10:03:12 -0800 (PST)
MIME-Version: 1.0
References: <20220214184104.1710107-1-dlatypov@google.com> <CAGS_qxomM_mGzvFokZH5dnf7L3kCitB3dWD8JH56fPcDSb6PeA@mail.gmail.com>
 <YgtLFwORwGggQ7M2@lahna>
In-Reply-To: <YgtLFwORwGggQ7M2@lahna>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 15 Feb 2022 10:03:01 -0800
Message-ID: <CAGS_qxrHUaCWNZ_sbTkhZvM9=BMN-ZH1LpMXCzxz=FbEeSx+Pg@mail.gmail.com>
Subject: Re: [PATCH] thunderbolt: test: get running under UML, add kunitconfig
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     brendanhiggins@google.com, davidgow@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 10:41 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi Daniel,
>
> On Mon, Feb 14, 2022 at 06:39:25PM -0800, Daniel Latypov wrote:
> > On Mon, Feb 14, 2022 at 10:41 AM Daniel Latypov <dlatypov@google.com> wrote:
> > >
> > > These tests didn't work under the normal `kunit.py run` command since
> > > they require CONFIG_PCI=y, which could not be set on ARCH=um.
> > >
> > > Commit 68f5d3f3b654 ("um: add PCI over virtio emulation driver") lets us
> > > do so. To make it so people don't have to figure out how to do so, we
> > > add a drivers/thunderbolt/.kunitconfig.
> > >
> > > Can now run these tests using
> > > $ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/thunderbolt
> > >
> > > Potentially controversial bits:
> > > 1. this .kunitconfig is UML-specific, can't do this for example
> > > $ ./tools/testing/kunit/kunit.py run --arch=x86_64 --kunitconfig=drivers/thunderbolt
> > > 2. this removes the manual call to __kunit_test_suites_init(), which
> > >    allowed us to control exactly when the tests got run.
> >
> > kernel-test-robot points out something I had forgotten.
> > Doing this prevents us from being able to build this test as a module.
> >
> > kunit_test_suites() defines an init_module() which conflicts with the
> > existing ones.
> >
> > There's some relevant discussion about reworking how kunit modules
> > work here, https://lore.kernel.org/linux-kselftest/e5fa413ed59083ca63f3479d507b972380da0dcf.camel@codeconstruct.com.au/
> >
> > So I think we have two options for this patch:
> > a) proceed, but disable building the test as a module for now (tristate => bool)
> > b) wait on this patch until kunit module support is refactored
> >
> > Basically the question is: does this slightly easier way of running
> > the test seem worth losing the ability to test as a module in the
> > short-term?
>
> I would like to keep the module option available.
>
> For me, I can just continue running this under QEMU for now so let's
> wait until the reworking has been done. Thanks for looking into this,
> though! :)

Sounds good.
We can treat this patch as just an example of what people can manually
do if they want to run tests under UML.

And I'll also look to this when I inevitably forget how to enable
CONFIG_PCI=y on UML again.

Thanks!
Daniel
