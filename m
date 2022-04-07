Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070054F8504
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 18:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345731AbiDGQbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 12:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345705AbiDGQbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 12:31:18 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591912654B;
        Thu,  7 Apr 2022 09:29:18 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id r13so12003866ejd.5;
        Thu, 07 Apr 2022 09:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=HLM2327HfIQSb5AwGCuDE4o35NVw/WE2roNt9nbAMpw=;
        b=Uu0jDkO/ISBZICB6UeYcaaVPdLs6mjY2zO5CvUzLhZJCfpu8rA64Wq5eNmFnobcm6O
         Li+yxDMAOMAzGY/9DGEIN7ndNquDMY+cyx7B40iPEivyszYbPYsjc3PQAxfH4dG5lFAh
         2SjWXNwE6LmV9D7kDuA+nI1eS4+eQsvPWeq1gpMm8BJAS1AN+pGthkLIAgAwHVTo2Dih
         2DeOu2Yqelv0pqLjAKhy5rOxOaQgDQ8EU57P1iPvPUGl0EXkfCUJFXQek8blf5AR3Voe
         m985dF7kqK5lPRCsaEmKFw6R+nRKJlLeEg9eNrl7fAUgQF2ZRmiG1RKlHwoAkjJjVgb1
         hBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=HLM2327HfIQSb5AwGCuDE4o35NVw/WE2roNt9nbAMpw=;
        b=AP9DTDci4U1JsZJHxqyh8oSIPAhrlMjMmzDfNBBBAXbAdyZqxyTipPVvAyhm4xH0NA
         5z7kwLcAM8EsnoTqN18Ukf45K3Z/1TegpdxiWk9XvdBRhoR6sfiBzSMg2HLJMXkRBN8G
         Lr3z+EMHCons7I6IKsjeTnfldgpNepg4ACVncpdTvBbUTjvV6fyPl5Pl1PukSXx9bn+N
         eRbcOJm9vvuxJG8FdyE23aQT84YgbWpW4eEMIlTtCH5QawHVq/AiI+v6osyXD5umuL0D
         7TIpcHiP7VYt+vwcSUnjcn4HLWbXAgLpeuG1+4VtmMKE+tnLiqwHQpVc1BWHzURoRHLs
         bF7A==
X-Gm-Message-State: AOAM533m9n9WjDF9tHupbN0PY/Q3f1r+psBNZRrMjS8UsJWjdxNVJOnn
        yJsyAfGukomcFr+4De0oqHo=
X-Google-Smtp-Source: ABdhPJx3W0Ld7YJ4+BlxNMXYyMAgifPw92xX89sWU5GQE09AdVcaHdKm224Kx8RPSjAAtHflEgUOTQ==
X-Received: by 2002:a17:907:c309:b0:6e8:4e5:6504 with SMTP id tl9-20020a170907c30900b006e804e56504mr13829576ejc.706.1649348941346;
        Thu, 07 Apr 2022 09:29:01 -0700 (PDT)
Received: from [192.168.3.2] (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.googlemail.com with ESMTPSA id d2-20020a1709067a0200b006df8c996b36sm7790329ejo.26.2022.04.07.09.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 09:29:00 -0700 (PDT)
Message-ID: <df19cba8bfa3adf67e32e36f6c9163008a278c68.camel@gmail.com>
Subject: Re: [PATCH v2 0/4] rpmb subsystem, uapi and virtio-rpmb driver
From:   Bean Huo <huobean@gmail.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc:     linux-kernel@vger.kernel.org, maxim.uvarov@linaro.org,
        joakim.bech@linaro.org, ulf.hansson@linaro.org,
        ilias.apalodimas@linaro.org, arnd@linaro.org,
        ruchika.gupta@linaro.org, tomas.winkler@intel.com,
        yang.huang@intel.com, bing.zhu@intel.com,
        Matti.Moell@opensynergy.com, hmo@opensynergy.com,
        linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org
Date:   Thu, 07 Apr 2022 18:28:59 +0200
In-Reply-To: <b95bdfa9-4373-8f54-677e-4a764061c61c@acm.org>
References: <20220405093759.1126835-1-alex.bennee@linaro.org>
         <8b3ce88f65fd11523a4d2daab3c617f7089eb1ce.camel@gmail.com>
         <87r16bk013.fsf@linaro.org>
         <aeb64d1c4bbddfd8463c07a40ab1fc78be0d158d.camel@gmail.com>
         <87ee2ajuky.fsf@linaro.org>
         <c18a2b359046a14250cafa5a619dbe53f2872b5a.camel@gmail.com>
         <e72812a9-1e5b-a826-d490-62ed23d94116@acm.org>
         <310d20a04bdaf40672592d9ffa950606d2ceaff7.camel@gmail.com>
         <b95bdfa9-4373-8f54-677e-4a764061c61c@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-04-06 at 13:20 -0700, Bart Van Assche wrote:
> On 4/6/22 11:12, Bean Huo wrote:
> > It is from the ufs-utils.
> >=20
> > So, do you vote to add the UFS RPMB driver based on this new
> > framework
> > to resolve this conflict?
>=20
> Are any applications using the RPMB code from ufs-utils? It seems to
> me=20
> that the ufs-utils code doe not handle SCSI unit attentions
> correctly.=20
> If a POWER ON unit attention is received as reply to a SECURITY
> PROTOCOL=20
> OUT transaction, the write counter should be reread instead of
> retrying=20
> the SECURITY PROTOCOL OUT command with the same write counter.
>=20

Not much sure how customers use this tool, based on my little
information from the field, the customer developed their own RPMB code
in the application. Here utils code is good example for them to study
and verify RPMB functinalities.

> Regarding adding a UFS RPMB driver: that seems useful to me since=20
> multiple applications make use of the UFS RPMB functionality. My=20
> understanding is that currently storageproxyd multiplexes UFS RPMB=20
> accesses in Android.
>=20

I have the same opinion with you, if we have an unified RPMB access
interface, and adding RPMB driver in the kernel, thus is better to
manage RPMB.

Kind regards,
Bean

> Thanks,
>=20
> Bart.

