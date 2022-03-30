Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6114EC6A1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346921AbiC3OgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 10:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244899AbiC3OgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:36:23 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79A641F87;
        Wed, 30 Mar 2022 07:34:36 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id kd21so14038839qvb.6;
        Wed, 30 Mar 2022 07:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to
         :content-language;
        bh=+lg9JnSYDKfs8RkjbzmPWemG+ehaocfcpwkWEPttL1Y=;
        b=Xi7ED40WCZZM57sQoCmOcrfcy5V+dWCMP5Y1btyV3QlE3hekvLO6635KtKM730FOsc
         s+MKoDk8y49qKePca7iED4ybfBH7v0+Qed+2LVH2H5GNXbtO+vt0FJN3L9PcZLnjMgRU
         v+YTjNzAFS5JOwV6taikosttbLfLJXCSt4pB36Uueed02JoASgYeRL/VbHCTAfyCjSpg
         ITli02fpVsDUAcf/cDLn+GibUa23I98ncq1hJWRIwoX2l8HIMojdCOgPI7nLnXwdGT+B
         ok3dprIRyLaEObHWDOL1LI1FfUT/r5LhxPRwSOKCqmIbIhfWTrqZIUTh5P978IbED4IJ
         I7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:content-language;
        bh=+lg9JnSYDKfs8RkjbzmPWemG+ehaocfcpwkWEPttL1Y=;
        b=2KLc5+x7DtiFLTJr/qY7W5aM6k4IrIFTy0+TmD4loejcy5CwInLiJ0lJ5hiMc5RyBd
         N4mO66gyUk+WwsxsFlx6LxSGjKiUlkgpFPq0uyxCqzni96NxoV7VC0GfNfAPPltsakZu
         M02BvmKEkaI6iiK7wIgvbn0jDnxfHej38MKDmr2za0YuqrzRGs7m4uotCAhHbSyfp2bv
         y0McOnDbCRolPlQO1ks415n8o9b0URRw5Ns1xcdqJcIHrDR+veDu+/fuQS+hgH7tQDo/
         +ZNcTvTJncuppPqEMZ/r75KTMsiz7fddOK4rd46bZKr7oIjRTUBuuXQJD6kVL+VWhi1g
         eF3A==
X-Gm-Message-State: AOAM5322rGoQWLlUGQbXFjhPq77TyKA8F9ytrKml0BvB7AzFT8q3uPv4
        bK2Er7oEu4SyZZF8K+EKbP2QPnOhMpm6bAZA
X-Google-Smtp-Source: ABdhPJyXH2hATliNrToMa3h7CAXz4q1HIaXy50CvB1yU7t+X6ZOY97mDeYMVnBsbp2TwLvpz3ISNrw==
X-Received: by 2002:a05:6214:765:b0:443:5e47:4573 with SMTP id f5-20020a056214076500b004435e474573mr12959979qvz.79.1648650875702;
        Wed, 30 Mar 2022 07:34:35 -0700 (PDT)
Received: from [192.168.1.115] (cable-217-24.sssnet.com. [24.140.217.24])
        by smtp.gmail.com with ESMTPSA id s131-20020a37a989000000b0067d2e3c51e8sm10930810qke.58.2022.03.30.07.34.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 07:34:34 -0700 (PDT)
Message-ID: <479c5c98-0e0d-072d-dae1-f91629989e46@gmail.com>
Date:   Wed, 30 Mar 2022 10:34:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   Ben Westover <kwestover.kw@gmail.com>
Subject: [PATCH] riscv: Set SRCARCH to riscv if ARCH is riscv64 or riscv32
To:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        masahiroy@kernel.org, michal.lkml@markovi.net,
        ndesaulniers@google.com
Content-Language: en-US
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------yHQiUDFiOFXls9MQsNFl0kie"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------yHQiUDFiOFXls9MQsNFl0kie
Content-Type: multipart/mixed; boundary="------------MZ7I7miqorRcsG55Xl7s3q92";
 protected-headers="v1"
From: Ben Westover <kwestover.kw@gmail.com>
To: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 masahiroy@kernel.org, michal.lkml@markovi.net, ndesaulniers@google.com
Message-ID: <479c5c98-0e0d-072d-dae1-f91629989e46@gmail.com>
Subject: [PATCH] riscv: Set SRCARCH to riscv if ARCH is riscv64 or riscv32

--------------MZ7I7miqorRcsG55Xl7s3q92
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

When riscv64 or riscv32 are used as the value for ARCH during compilation=
, like
in tools that get the ARCH value from uname, set SRCARCH to riscv instead=
 of
failing because the riscv64 and riscv32 targets don't exist.

Signed-off-by: Ben Westover <kwestover.kw@gmail.com>
---
 Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Makefile b/Makefile
index c28c5d91e5c8..315c364bf2ba 100644
--- a/Makefile
+++ b/Makefile
@@ -408,6 +408,14 @@ ifeq ($(ARCH),parisc64)
        SRCARCH :=3D parisc
 endif

+# Additional ARCH settings for riscv
+ifeq ($(ARCH),riscv32)
+       SRCARCH :=3D riscv
+endif
+ifeq ($(ARCH),riscv64)
+       SRCARCH :=3D riscv
+endif
+
 export cross_compiling :=3D
 ifneq ($(SRCARCH),$(SUBARCH))
 cross_compiling :=3D 1
--=20
2.35.1


--------------MZ7I7miqorRcsG55Xl7s3q92--

--------------yHQiUDFiOFXls9MQsNFl0kie
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEOGnacqRhdU6eNmtFwxHF9U6JtpgFAmJEangFAwAAAAAACgkQwxHF9U6JtpgZ
4xAAn/q/ybWe+TLW4f/X3/SsAbr+KytS59VHXMsE0cavhd6KvWYA9KKc1jjxbaQAbSHYZcCo5tAB
sFLAB0gJyLyyev75/FTITMbfCW1ayPwk+HsmRyx9D7yQk8Pi1aGXnF/SAqneITYU10KnjYQP0OA2
K16o2E+DYLQ66vp0U5BA2gU/NAcN50BXKz+oSZbBZ4CEnvhl+Kpb20ZPhIG/1tmhPYgQLMWJl/F1
Em7CF3SLj6m1FFt4Z+qJzP3AfXBr6Z9JmqqmFZXxHQeyI0CTywsdQ8C9XLK1CiypNB0ubeT2WXbg
1qXm5/VWmG9YQh7oVqgtDwbV0NkAWrcYhWGT5CoxkDZnAavfx8wpo7l3EodfekuHt0s2Uei9MP0E
k6fQEW6a9Cu4fNGY2kmPaUsDVIJHQrUzVz5ltRvdLnkSOQ87S+kxFlGUreSsHb38tnTvfN3gn4uf
2S41M9o3vwaI/jJ0X5Y5HmB5YYS1kUBB4JYwQMSeKubouc/mrkmlnqhlgl5i8O6/yHbcYbQHIoNk
HdxpxSsM5WucZj7Opr3SGx+tTXzQXOkeorPPnM+zIy6LR+AvOQDwF4tetX9leOGIOHL382vwaJT8
xloVcn6ex3qrEHhyaBL0LV3QLN98UKtXTYPWISMlIFpSGvL+6X3ubkhLMrJLcBN9VNc2Cdq4NhLq
8d4=
=MkCD
-----END PGP SIGNATURE-----

--------------yHQiUDFiOFXls9MQsNFl0kie--
