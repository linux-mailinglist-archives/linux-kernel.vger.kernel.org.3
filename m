Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E0D4D01AE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243350AbiCGOp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239555AbiCGOp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:45:27 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB2B140EF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 06:44:32 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id z11so13945152pla.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 06:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5LigUQH3eW5GSlPkafEnbTkMfLkaSU6yR36/4QRsjNw=;
        b=Bj2iJMwPQ9Dc+ArNwHzYLW3J5J+tEB3ta2nPO3ROhKtqFn/WN8+nK3oscWG3hjsjKj
         nRSaasKIOfnqm8nMJdhplfrsu/IldF8haJT33RHEssR4peHHgcA5G9tB0Yc9tafYiXhZ
         lDEoN4i7wXGwhU6YwYpCwFbKy/zu3bEJob5xtPC+7LSEIsD7OE9WamReIbgaqS3DKrcw
         7IgcNC88X9d9+rZsbR8aDoTDcx5UT5eI/8QUuA5yrJstko1gxEDRtoARyYgAnRUJjCPn
         htoNB8gk7O6u8sAP3Vn5ela4wrKoWzYPbtxRbxvWfl4TEbTxsmpkjNvDFjASE+ozTC6v
         gMvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5LigUQH3eW5GSlPkafEnbTkMfLkaSU6yR36/4QRsjNw=;
        b=yF/tbClyyrTBuWbH8H8RAz1bcHZf5PbUJ/u4JtsA7sSjbNs9Au7lPEyNLqhYjF6UEJ
         wLb75J04c+FHyDeFJjnHFuvLk28Zpgp9tk8fLYZrU3YleNtrQoVPuZvGMeSXH3lih5r9
         OMXf7nP+gAUMs0Y/c2PfCSmYEI44npwnDVDZAooHaVWOWT3lk1eZjF6YUYj/3dYhg2Iy
         VSTrKpQNmMYQBUQAWaqQ055TwZMv7vEw1hzyHbSeI40zC0eRwxmI7x/10Yblf+CTTy/B
         V15xov7IY1l73rEOhs5WD04XbmKBNz1u8oF64daje1mTLHdw4lMdV2OtS7jYFqWcDjMg
         bLqg==
X-Gm-Message-State: AOAM533htqhcXBQLNTSvUE3C2gq47RLBrpsJfZX3gd792C6Rjav/27l3
        ZLfVoAjvtv1ctVt8caDVwUWdb7LBMZMJjttl/LTcv6fpSNU=
X-Google-Smtp-Source: ABdhPJwhDSh1G5LGY9HlfurVD/gGTfbGJNcUYLE77BAIahsHjetsjgD//7R9H9Uy23Zcn6xNcSfsfQJV5bUWgmaGFss=
X-Received: by 2002:a17:902:a3cb:b0:151:e52e:fa0c with SMTP id
 q11-20020a170902a3cb00b00151e52efa0cmr6138611plb.70.1646664271812; Mon, 07
 Mar 2022 06:44:31 -0800 (PST)
MIME-Version: 1.0
References: <20220307094042.48446-1-clement.leger@bootlin.com>
 <CAHUa44FJEsd1wc=E0p+4pHU1=31z7JTgNDyz9Vxx77N11B8RKg@mail.gmail.com> <20220307120000.49f88c8b@fixe.home>
In-Reply-To: <20220307120000.49f88c8b@fixe.home>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 7 Mar 2022 15:44:20 +0100
Message-ID: <CAHUa44H_hjSK0hh1Kz50pO4=985njD_A8AGkgD6C8Uf9Jvs8Qw@mail.gmail.com>
Subject: Re: [PATCH v2] rtc: optee: add RTC driver for OP-TEE RTC PTA
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 7, 2022 at 12:01 PM Cl=C3=A9ment L=C3=A9ger <clement.leger@boot=
lin.com> wrote:
>
> Le Mon, 7 Mar 2022 11:40:38 +0100,
> Jens Wiklander <jens.wiklander@linaro.org> a =C3=A9crit :
>
> > On Mon, Mar 7, 2022 at 10:42 AM Cl=C3=A9ment L=C3=A9ger <clement.leger@=
bootlin.com> wrote:
> > >
> > > This drivers allows to communicate with a RTC PTA handled by OP-TEE [=
1].
> > > This PTA allows to query RTC information, set/get time and set/get
> > > offset depending on the supported features.
> > >
> > > [1] https://github.com/OP-TEE/optee_os/pull/5179
> > >
> > > Signed-off-by: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
> > > ---
> > >
> > > Changes in v2:
> >
> > Hmm, this seems to be a second v2.
>
> Hmpf, I answered to Etienne questions on V1 and forgot I already sent a
> V2.
>
> >
> > >  - Rebased over tee-shm-for-v5.18
> > >  - Switch to tee_shm_alloc_kernel_buf()
> > >  - Use export_uuid() to copy uuid
> > >  - Fix warnings reported by checkpatch
> > >  - Free SHM in error exit path
> > >  - Fix error messages to include ret value and fix wrong IOCTL names
> > >  - Use 100 columns char limit
> >
> > From bdc48fa11e46 ("checkpatch/coding-style: deprecate 80-column warnin=
g"):
> >     Yes, staying withing 80 columns is certainly still _preferred_.  Bu=
t
> >     it's not the hard limit that the checkpatch warnings imply, and oth=
er
> >     concerns can most certainly dominate.
> >
> >     Increase the default limit to 100 characters.  Not because 100
> >     characters is some hard limit either, but that's certainly a "what =
are
> >     you doing" kind of value and less likely to be about the occasional
> >     slightly longer lines.
>
> Ok.
>
> > > +
> > > +       if (param[0].u.memref.size !=3D sizeof(*optee_tm)) {
> > > +               dev_err(dev, "Invalid read size from OPTEE\n");
> > > +               return -EPROTO;
> > > +       }
> >
> > The dev_err() prints above are basically covering "can't happen"
> > cases. Robust code should certainly do the checks, but I'm not so sure
> > about how useful the prints are.
>
> Agreed, if it fails, this is likely to be due to protocol changes and
> thus, the developer will probably know where to search for the error.
>
> [...]
>
> > > +static int optee_rtc_probe(struct device *dev)
> > > +{
> > > +       struct tee_client_device *rtc_device =3D to_tee_client_device=
(dev);
> > > +       struct tee_ioctl_open_session_arg sess_arg;
> > > +       struct optee_rtc *priv;
> > > +       struct rtc_device *rtc;
> > > +       struct tee_shm *shm;
> > > +       int ret, err;
> > > +
> > > +       memset(&sess_arg, 0, sizeof(sess_arg));
> > > +
> > > +       priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > > +       if (!priv)
> > > +               return -ENOMEM;
> > > +
> > > +       rtc =3D devm_rtc_allocate_device(dev);
> > > +       if (IS_ERR(rtc))
> > > +               return PTR_ERR(rtc);
> > > +
> > > +       /* Open context with TEE driver */
> > > +       priv->ctx =3D tee_client_open_context(NULL, optee_ctx_match, =
NULL, NULL);
> > > +       if (IS_ERR(priv->ctx))
> > > +               return -ENODEV;
> > > +
> > > +       /* Open session with rtc Trusted App */
> > > +       export_uuid(sess_arg.uuid, &rtc_device->id.uuid);
> > > +       sess_arg.clnt_login =3D TEE_IOCTL_LOGIN_REE_KERNEL;
> > > +
> > > +       ret =3D tee_client_open_session(priv->ctx, &sess_arg, NULL);
> > > +       if (ret < 0 || sess_arg.ret !=3D 0) {
> > > +               dev_err(dev, "tee_client_open_session failed, err: %x=
\n", sess_arg.ret);
> >
> > This print is the most useful print in the driver. This is typically
> > reached if the PTA doesn't exist.
>
> If the PTA does not exists, is the driver even probed ? I thought it
> was based on the UUID matching.

Yes, it is, but perhaps there's some configuration mismatch or something.

>
> >
> > > +               err =3D -EINVAL;
> > > +               goto out_ctx;
> > > +       }
> > > +       priv->session_id =3D sess_arg.session;
> > > +
> > > +       shm =3D tee_shm_alloc_kernel_buf(priv->ctx, sizeof(struct opt=
ee_rtc_info));
> > > +       if (IS_ERR(shm)) {
> > > +               dev_err(priv->dev, "tee_shm_alloc_kernel_buf failed\n=
");
> > > +               err =3D PTR_ERR(shm);
> > > +               goto out_sess;
> > > +       }
> > > +
> > > +       priv->shm =3D shm;
> > > +       priv->dev =3D dev;
> > > +       dev_set_drvdata(dev, priv);
> > > +
> > > +       rtc->ops =3D &optee_rtc_ops;
> > > +
> > > +       err =3D optee_rtc_read_info(dev, rtc, &priv->features);
> > > +       if (err) {
> > > +               dev_err(dev, "Failed to get RTC features from OP-TEE\=
n");
> >
> > This print could also be worth keeping, but the rest are in my opinion
> > of limited interest.
> >
> > It's a tradeoff with the prints, no big deal if you'd like to keep more=
.
>
> I'm ok with that statement. The runtime errors are less likely (if not
> totally unlikely) to happen. I'll sent a new version (V4 this time...)
> with theses modifications.

OK.

Cheers,
Jens

>
> Thanks,
>
> --
> Cl=C3=A9ment L=C3=A9ger,
> Embedded Linux and Kernel engineer at Bootlin
> https://bootlin.com
