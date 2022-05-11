Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC08523B6E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 19:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345479AbiEKRXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 13:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345444AbiEKRXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 13:23:37 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A854521719C;
        Wed, 11 May 2022 10:23:35 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id q23so3959808wra.1;
        Wed, 11 May 2022 10:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t+uExahuLFs0lwI65+li3ZxmFaNfaWHqSTSJZ2XjbAs=;
        b=LEDNVSFLwfFJoutNu7Z+cuVLwScWtXpYqs/aKugxuTaEVH9u7G64kOa0gpyma9L+FL
         ILmOzR6KK59WZT8muKWEDKti0z/Hd3nhlHbgCza9CGhdPnKnvC+mWOg07sgY4RyE/b/S
         uFSvTeHSUMk3ov/GzmhAAOeiDs8k5APMzC8KqFhMNudS9Rdjc8I9m7cRjHZP02/6SfhF
         b0h6RDaiZ373YcGDejut/NcvERdMDjI8tfv0NF0P0hosYAT9/1lew9OGWmtBCq4UyoaT
         I7k1Y+hUtdJZvTGurSwdWOifp9+lFYkurtrzDU1ps7RjVcyXHMo7hErN4AHUZNVMnSjx
         PCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t+uExahuLFs0lwI65+li3ZxmFaNfaWHqSTSJZ2XjbAs=;
        b=nHb3ABa7NE1IOtb0uBwJCMi7y3DzzbSFe7DA2nP0S1F/W6Rqh/ZxpiI7h+khF/9hBX
         xbbLFK/mYxOFT/k0hPSC84642cKXoIIXks390UfyktyAnQ/S6gNSCkmHVtWjWS7s84EJ
         xfeR23aOvDq7QrozoNCTl7kAh3xxRzydrghqdaYtLJwvaohQqhqISctHhiWunCkdw3WJ
         jRQCU842a23pT+y+rAfByZj+YHK/kYOwv/l1/TVkASiGrV7OE9WY7r6a2TTOLeBGMhsw
         Cl5MYOVfdlG+wfSdhWqjaspOwCIv+oQYGm9rb53qfxJu7M7qXVGAFrbRFy2sRn2cWd5M
         TF9g==
X-Gm-Message-State: AOAM530x9mXay19iv4/3wO884rJ/gXkUtmKyqH/a2bLnr7CxoTohAHiM
        D4Nea0/c42DXoV4gmtGBNrqbP8ZwzymyXfmtSPk=
X-Google-Smtp-Source: ABdhPJyC6inV6eAWLK0ZXsHs0MrWHXEsfMAJsBP34QdhxVkct3PvJuiGu3x0A+V1OdjNNJe8DBpE4CuVih15n0h5kXc=
X-Received: by 2002:a05:6000:156e:b0:20c:5218:8907 with SMTP id
 14-20020a056000156e00b0020c52188907mr23626979wrz.297.1652289814014; Wed, 11
 May 2022 10:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220510070140.45407-1-tomeu.vizoso@collabora.com>
 <20220510141329.54414-1-tomeu.vizoso@collabora.com> <CAPM=9tzLR-wsLhg2ikGjoK06s-ju5XWa1rtPPiUpN=pwD1vgtA@mail.gmail.com>
 <YntWQIXSqMCd6TYV@kroah.com> <1255a66a-121d-988a-19a7-316f703cb37d@mailbox.org>
 <YnujG0nkF0U6d5kd@kroah.com> <CAF6AEGsmD-CNGj4bAE952JQpquaWA+Nxo5TGpFiHqaPK9doP-g@mail.gmail.com>
 <CAKMK7uH8k6j5jE562yvbtBaE8EnM8JGF7zOXT4C62HdOgOs9SQ@mail.gmail.com>
In-Reply-To: <CAKMK7uH8k6j5jE562yvbtBaE8EnM8JGF7zOXT4C62HdOgOs9SQ@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 11 May 2022 10:23:21 -0700
Message-ID: <CAF6AEGvF9aaAiggAmdBq-OQ0BP5-+3YmdL+P2=Vm4LAEf0aqvg@mail.gmail.com>
Subject: Re: [Freedreno] Adding CI results to the kernel tree was Re: [RFC v2]
 drm/msm: Add initial ci/ subdirectory
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Sean Paul <sean@poorly.run>,
        freedreno <freedreno@lists.freedesktop.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 9:43 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Wed, 11 May 2022 at 15:33, Rob Clark <robdclark@gmail.com> wrote:
> > On Wed, May 11, 2022 at 4:50 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, May 11, 2022 at 12:26:05PM +0200, Michel D=C3=A4nzer wrote:
> > > > On 2022-05-11 08:22, Greg Kroah-Hartman wrote:
> > > > > On Wed, May 11, 2022 at 03:06:47PM +1000, Dave Airlie wrote:
> > > > >>> And use it to store expectations about what the drm/msm driver =
is
> > > > >>> supposed to pass in the IGT test suite.
> > > > >>
> > > > >> I wanted to loop in Linus/Greg to see if there are any issues ra=
ised
> > > > >> by adding CI results file to the tree in their minds, or if any =
other
> > > > >> subsystem has done this already, and it's all fine.
> > > > >
> > > > > Why does the results need to be added to the tree?  Shouldn't the=
y be
> > > > > either "all is good" or "constantly changing and a constant churn=
"?
> > > > >
> > > > >> I think this is a good thing after our Mesa experience, but Mesa=
 has a
> > > > >> lot tighter integration here, so I want to get some more opinion=
s
> > > > >> outside the group.
> > > > >
> > > > > For systems that have "tight integration" this might make sense a=
s proof
> > > > > that all is working for a specific commit, but I can't see how th=
is will
> > > > > help the kernel out much.
> > > > >
> > > > > What are you going to do with these results being checked in all =
the
> > > > > time?
> > > >
> > > > Having the expected results in the tree keeps them consistent with =
the driver code itself, and allows putting in place gating CI to prevent me=
rging driver changes which make any of the tests deviate from the expected =
result.
> > >
> > > Shouldn't "expected result" always be "pass"?
> > >
> > > If not, then the test should be changed to be "skipped" like we have
> > > today in the kselftest tests.
> >
> > No, we want to run tests even if they are expected to fail.  This
> > prevents the scenario of a test getting fixed without being noticed
> > (for ex, developer was working on fixing test A and didn't notice that
> > the fix also fixed test B).  If a fix goes unnoticed, a later
> > regression would also go unnoticed ;-)
> >
> > I was skeptical about this approach at first with mesa CI, but having
> > used mesa CI for a while, I am now a firm believer in the approach.
> >
> > And ofc we want the expectations to be in the kernel tree because
> > there could be, for example, differences between -fixes and -next
> > branches.  (Or even stable kernel branches if/when we get to the point
> > of running CI on those.)
>
> Yeah result files in tree is kinda needed, even more so for the
> kernel. A lot of the linux-next integration testing is only done after
> patches have landed, and sometimes such breakage makes it to upstream
> and then into the subsystem/driver tree. Annotating in the backmerge
> what exactly broke and why helps a lot with tracking issues.
>
> And expecting every subsystem to run every other subsystem's tests,
> especially tests that run on hw, is just not going to scale. So there
> will be all kinds of difference in test results.
>
> > > And how about tieing this into the kselftest process as well, why wou=
ld
> > > this be somehow separate from the rest of the kernel tests?
> > >
> > > > Keeping them separate inevitably results in divergence between the =
driver code and the expected test results, which would result in spurious f=
ailures of such CI.
> > >
> > > Again, "pass" should be the expected results :)
> > >
> > > > I expect the main complication for the kernel will be due to driver=
 changes merged via different trees, e.g. for cross-subsystem reworks. Sinc=
e those will not go through the same CI, they may accidentally introduce in=
consistencies. The ideal solution for this IMO would be centralizing CI suc=
h that the same gating tests have to pass regardless of how the code is mer=
ged. But there's likely quite a long way to go until we get there. :)
> > >
> > > We have in-kernel tests for the rest of the kernel, why can't you put
> > > your testing stuff into there as well?
> >
> > We could ofc put a lot more of the gitlab yml and scripts into the
> > kernel tree.  Probably all of i-g-t is a bit much to put in the kernel
> > tree.  Not to mention I'd like to see this expand to also run some
> > deqp and/or piglit tests, which is definitely too much to vendor into
> > the kernel tree.
> >
> > The approach of this RFC was to put only what was absolutely required
> > in the kernel tree (such as expectations), and then link out to an
> > external drm-ci tree[1] which has all the necessary scripts and yml
> > for building and running tests, to avoid having to put a whole lot
> > more in the kernel tree. (We should be specifying exact commit-sha for
> > that tree, IMO, as it controls the version of i-g-t which gets used,
> > and we need to be able to update expectations in sync with an i-g-t
> > uprev, for example when new tests are added or if a test fix caused a
> > fail->pass transition.)
>
> Yeah I think longer-term we should carry a lot more in upstream, at
> least anything that's shared across drivers wrt the ci integration (or
> build testing and running tests which are hw agnostic). Maybe even
> igt, not sure (otoh xfs-tests isn't moving into the kernel either, and
> there's lots more like that).

A lot of the drm-ci tree is the scripts/etc for things like power
control, booting, etc.. and a lot of that is identical to what we have
in the mesa tree (since the on-hw tests run on the same CI farms as
mesa-ci)

But ofc it can be re-used by other drivers via one line in toplevel
$driver/ci/gitlab-ci.yml, ie:

  DRM_CI_PROJECT_PATH: &drm-ci-project-path gfx-ci/drm-ci

BR,
-R

> Personally I think long-term the only thing outside should be other
> repos with tests or stuff you need to run them, and not really the
> glue to make it all work in ci. But that's maybe a bit too much
> wishful thinking if CI systems stay largely subsystem specific (which
> they currently are in many ways, with some overlap).
>
> But maybe there is enough random pieces to share here for a lot more
> in-tree to make sense, and imo the fewer extra steps and indirection
> CI testing and test updating has, the better.
>
> But like Rob says, eventually there's a limit and when you put the
> entire GL/vulkan stack + it's conformance testsuite (which is
> maintained by khronos somewhere completely different than both
> kernel.org and freedesktop.org) then it's definitely too much and wont
> work. And eventually we do want to run these things too (e.g.
> intel-gfx-ci does run mesa + piglit on every run).
> -Daniel
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
