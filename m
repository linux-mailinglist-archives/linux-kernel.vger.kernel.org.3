Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1047758CE79
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 21:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244399AbiHHTQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 15:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244314AbiHHTQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 15:16:29 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF7711F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 12:16:28 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-10edfa2d57dso11670958fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 12:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=tTjklP3N0xHZTapO1AHhc2qFb7IfKSUYUkpCWo6nNBY=;
        b=ZSOKztoCgboaGeteudYq4N3KYqQ8UIgYnji3gooMEzV5IRLYEh+XF1ZRfuD0EGQrGF
         /E5OcSx0xKOH11XrTJPWF+sWMQaMqK/KIw2Gn/HV+UkLhhIPbxsCiCVYwrHYOygGXOwp
         ysmzW9/YW9ZTCzsJ5xmf0IynMV0hA+2Wlu3q79QKSXFYtbzcxOixwKNLFB0KJirPHRAL
         NLod93cpmJ39y5iOiEmfdQlJoAQMc9YkzV6IaGtgO7QtNR6QLA8ZVCKk3n3rzMOb0QFT
         gp0dVQ7ArUGhq7F2E/q+wXMZN5JYN2YUZY594kavlTlFPRiqBWRKPPywn8ogyCZaDdmL
         JOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=tTjklP3N0xHZTapO1AHhc2qFb7IfKSUYUkpCWo6nNBY=;
        b=0DNEItQWwh59W2niJv67CyKewxk0LBGnE9QJ+dcLQE04M04YI07FngARBmLmxIPeFN
         mYGpbeL6QNjf7T8nWeDcEfC3HbvknPAlc+L7Bxl/itqjnRtAc5/228xG/WBbXdu+mMBz
         JbBAT3NG1rDAfoiCya+QC2EGqHSU0ccQqgy9AvvWI2YBQiJ3WmjboCSFCfvHUIvbgrUF
         RDeaFiF7jt/s0poOKhdCPs4LyipN/Pvtf6Kpr96dAMuHw1gXplJhr7fVyD27nYZaOX64
         GWUYBvDDHcxT1z1D2C2xlu0pBeIJ8wh0hlBIttyM+3aI3DV/cyPkFnRlF6MOEU/z3cng
         cbEw==
X-Gm-Message-State: ACgBeo00QVlHdqa+jqlkvFIkxzPSmQODbG4unxcHyyiYmUtUK+/0kVQj
        /bqOCUCMTM4tHXLIkBpbRX2CnG3R3kMO5il2thsI
X-Google-Smtp-Source: AA6agR7Aw2cmXn+MTX3OJNveQNvS7hRoJuqGGAJUvFdZ+o5Hkr7Sb0J1aD17Nf+ppmZUi+oakuDbzPdW9LVLREpdZNw=
X-Received: by 2002:a05:6870:9588:b0:101:c003:bfe6 with SMTP id
 k8-20020a056870958800b00101c003bfe6mr12980423oao.41.1659986187604; Mon, 08
 Aug 2022 12:16:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220801180146.1157914-1-fred@cloudflare.com> <87les7cq03.fsf@email.froward.int.ebiederm.org>
 <CAHC9VhRpUxyxkPaTz1scGeRm+i4KviQQA7WismOX2q5agzC+DQ@mail.gmail.com> <87wnbia7jh.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87wnbia7jh.fsf@email.froward.int.ebiederm.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 8 Aug 2022 15:16:16 -0400
Message-ID: <CAHC9VhS3udhEecVYVvHm=tuqiPGh034-xPqXYtFjBk23+p-Szg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Introduce security_create_user_ns()
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Frederick Lawler <fred@cloudflare.com>, kpsingh@kernel.org,
        revest@chromium.org, jackmanb@chromium.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        shuah@kernel.org, brauner@kernel.org, casey@schaufler-ca.com,
        bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        kernel-team@cloudflare.com, cgzones@googlemail.com,
        karl@bigbadwolfsecurity.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 8, 2022 at 2:56 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> Paul Moore <paul@paul-moore.com> writes:
> > On Mon, Aug 1, 2022 at 10:56 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >> Frederick Lawler <fred@cloudflare.com> writes:
> >>
> >> > While creating a LSM BPF MAC policy to block user namespace creation, we
> >> > used the LSM cred_prepare hook because that is the closest hook to prevent
> >> > a call to create_user_ns().
> >>
> >> Re-nack for all of the same reasons.
> >> AKA This can only break the users of the user namespace.
> >>
> >> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> >>
> >> You aren't fixing what your problem you are papering over it by denying
> >> access to the user namespace.
> >>
> >> Nack Nack Nack.
> >>
> >> Stop.
> >>
> >> Go back to the drawing board.
> >>
> >> Do not pass go.
> >>
> >> Do not collect $200.
> >
> > If you want us to take your comments seriously Eric, you need to
> > provide the list with some constructive feedback that would allow
> > Frederick to move forward with a solution to the use case that has
> > been proposed.  You response above may be many things, but it is
> > certainly not that.
>
> I did provide constructive feedback.  My feedback to his problem
> was to address the real problem of bugs in the kernel.

We've heard from several people who have use cases which require
adding LSM-level access controls and observability to user namespace
creation.  This is the problem we are trying to solve here; if you do
not like the approach proposed in this patchset please suggest another
implementation that allows LSMs visibility into user namespace
creation.

-- 
paul-moore.com
