Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE62B56A865
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 18:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236298AbiGGQkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236365AbiGGQjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:39:53 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB1C599D5;
        Thu,  7 Jul 2022 09:39:51 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id r6so12436132edd.7;
        Thu, 07 Jul 2022 09:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zZ6bGCTSYduPCX5Q26BHPCc6+2axtS3otmjoB+0kPR4=;
        b=d9TyqrOdTkgZXDwoyjfarVcFPPKHN+HKcdPPmfyx1nIA9a+kohCsXC/GApZE0M7Fh0
         YYtX2PvZffaN95r9LJle26CiRzvcHYRObDMJmSgHf8kChk4J15ovyEyfCRrbdisYFlQt
         1Qw7RGGI9CM4+gu9Mnk/vPHgFtvrnKB7qQCuwdfyXRGFoql9GwpAgD60srnonPaV0iVm
         H+V9fdiq1VIJg2cRm66+b6M1CwnLTBCjsw+Mh0LSO3ciSO57ndFeMwtDbU/B+R9d7c9/
         C/GUm+5tsAu+8dXhrChKSdN33aFb6Xh9/VNz/FB40huDKbKPmmGzLb27/huHXWVw2nr7
         PwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zZ6bGCTSYduPCX5Q26BHPCc6+2axtS3otmjoB+0kPR4=;
        b=D26XUbL4YrCtT9VQwt8lhKb3uaiAPoXMecqBnoyhRXVSusFCyxPKkTsJJOY4Y9JmaZ
         7WiGNxCT9PkJeUXUJZy3CJXSq+1M8X2wUbQd6jHxzlsGJGF0CsmwGSnBRlpDjdnNdFu1
         w6ZV3q1KQFVdGn1m9CpQrnAURxeAPFnex8raSRmHwar8EfMPiZlRkqGZUHDR0BfdkyPk
         PUkZxx/tdQwkRn7dr/k+q5p7kvcZkvzKSLRgRKG41/StxYHdJIGb+vcUU6GCfyabosLY
         MuLlxN0RqMahBZ7EHaMs3ixRx+HQBxNCd8a4nyjKeVn5dMq/MYbYrveAQ/t0oAWLQAR4
         sCOg==
X-Gm-Message-State: AJIora97ERulljLgiT/RwHCtybaUjrRufeIMTAdWIPXJ28LtsGQsmv18
        Koh1HMDGj8wq9zZLyqZnICA=
X-Google-Smtp-Source: AGRyM1s7GBiMti35T3Z3Jqt+j7fJXLzWaw6kB4stOv/phD3kooyxCr73C1ouHt27cq5QrP8oBlKR9w==
X-Received: by 2002:aa7:c98f:0:b0:43a:71c2:3f7e with SMTP id c15-20020aa7c98f000000b0043a71c23f7emr25312176edt.60.1657211989669;
        Thu, 07 Jul 2022 09:39:49 -0700 (PDT)
Received: from jernej-laptop.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id f22-20020a17090631d600b0072a3958ed33sm11912293ejf.63.2022.07.07.09.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 09:39:49 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Andre Przywara <andre.przywara@arm.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 3/6] arm64: dts: allwinner: Add Allwinner H616 .dtsi file
Date:   Thu, 07 Jul 2022 18:39:47 +0200
Message-ID: <2187076.iZASKD2KPV@jernej-laptop>
In-Reply-To: <39537f95-2ed4-f526-5912-364c1c1ed512@sholland.org>
References: <20220428230933.15262-1-andre.przywara@arm.com> <20220706141655.15d2dd0e@donnerap.cambridge.arm.com> <39537f95-2ed4-f526-5912-364c1c1ed512@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne =C4=8Detrtek, 07. julij 2022 ob 08:30:32 CEST je Samuel Holland napisal=
(a):
> Hi Andre, Jernej,
>=20
> On 7/6/22 8:16 AM, Andre Przywara wrote:
> > so after seemingly having finished writing this email, I realised that
> > this won't really help, as I think this diverts the discussion. And the
> > problem has been around for a while, and won't probably be solved easily
> > or quickly. I think we agree to disagree here, or we should admit that
> > there are different approaches ("bundled firmware" vs. "UEFI"), so in t=
he
> > interest of not blocking the H616 series:
> >=20
> > Shall I just keep the firmware node? This would work both ways, whereas
> > dropping the node would impede the "bundled firmware" approach?
>=20
> Let me try to sum up the relevant portion of my thoughts (and save the re=
st
> for elsewhere):
>=20
> The only reason to add the reserved-memory node is to support
> externally-loaded DTBs. By adding the node, we are committing to support
> externally-loaded DTBs on this SoC.
>=20
> Upgrading the kernel is not allowed to break boot. If we support
> externally-loaded DTBs, that rule extends to DTBs shipped with the kernel.
>=20
> If we remove the reserved-memory node, the combination of old U-Boot + new
> externally-loaded DTB will stop booting (the kernel version is irrelevant=
).
> Therefore, if we add the node, we can never remove it, full stop.
>=20
> I will (begrudgingly) accept that, as long as the node matches what TF-A
> actually generates today. That means, please:
>  - Drop the label and update the node name
>  - Reduce the size to 256 KiB, matching (BL31_LIMIT - BL31_BASE)

In the interest of moving things forward, I agree to that.

Best regards,
Jernej




