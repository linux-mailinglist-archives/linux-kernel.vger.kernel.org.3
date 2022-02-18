Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E69E4BAE18
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiBRAKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 19:10:09 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiBRAKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 19:10:05 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7243053B4D;
        Thu, 17 Feb 2022 16:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645142969;
        bh=4ltnXb8snLk/03M1NrAk+PfKScHzFXRMa+IBBhisrD4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=M/bl8FoIpMg0PQD26wHWBsbu4zVsgfaZz3wI0jy9lYvNsQTYiPJR1uajlQVEoTui2
         CENcRkOkKRHjHMNlWrRENGOR3alKvUfuhEllmaGGEk/WII/LKPUvGo/OV2Mjt7CXtv
         do5UgR3lyJHtP7NtJ2JWZUwMYyrKUqkO9flD6iQo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtOGU-1o7bPC49z4-00uptg; Fri, 18
 Feb 2022 01:09:29 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Yang Ling <gnaygnil@gmail.com>
Subject: [PATCH v4 2/5] clk: loongson1: Terminate clk_div_table with sentinel element
Date:   Fri, 18 Feb 2022 01:09:18 +0100
Message-Id: <20220218000922.134857-3-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218000922.134857-1-j.neuschaefer@gmx.net>
References: <20220218000922.134857-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wIeA3EpWZ2D/QrBiVRtabFv6htYrl8luxA9LG3fPYVV3/DUZYEO
 TQxYKZHnp6ehklZ+aUvGdJ8FPBzmsSYoNw8PBuPvYxxX4uKE4GWTons4wx86M4Yhe1HzvIr
 scCyLZmNZxBxwfbkhcwSvGVaNgvXtsT08CPW47e8Pn/iUXMhOvhuwwPI66EZ6JsQG2vulG9
 sx7ymXT11UX7C5Nl9AvOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U+6GU7dX1MY=:XODRymg5Z7mQmphJMhhakb
 Vr/sO3FPucXX4JpqpCIynvdNmhRmahzdlrVP3sB5ZFgzK9H7GZTxMc1lEGYOiUK19hlQ9y/F8
 SFoS2fC8zn/ifuzZjCBz3Pek8AWbpZ/Oy0EJqEKUgRYlWDwIRf0Sf7P3/7yTKf6zEDB0kkTL7
 mUcyvw2UUOdBgYVwxuIKGJatXom0mnue3BDzt2LhM6ZE1oAqFTHrLTE2kns+hKuC6JP1cXVVo
 PJpRB6zUaiOMQ9wYwlkWZgPUVwg8lJUgi+af2RE6Q5Hmg/Rc3KMdAyu+rWFjfVes9zHbLICwD
 gyU/3UOfxy5JqlDcFoShFwIP3k7PgAaQLRaoqeWojyy0DSTyjryFrCnIRpeicrshqDcxY0xNU
 7oq33R51muUDWkb9+Q+1EBu1o3193QiLej2JKiIMeH50S0hHWzgaWTYXn92MPXGF9GH2xWxAL
 i80XJvW015t4KQcOowaqzLeSTDHTebROuKSiRPcTndqCdCjTDQhNUXGbC9OQSMjRLdvxKxQIg
 CrmNiBzxqFwr6vf9omDqb0zTXWV4T1vgIyrk8j+/+fg1g1sMpEoYuAOINP9iat+ZvzEcaMZAu
 fU24RCLp3Rhob59FfTOasS//mfE2wtpodV5DUagg4GToInA/Voz05HDFhT0Vk4YYnU+0wcQN+
 T2RSMkoalt6IHb1kHrlk//Uv31xVyzULyunycnUeZkoB77reRIqIk3RttKCtcbbr8L0d1dX5k
 pf7Hi7Zogy2S3rnI/PGzFd5tW6kZF1AtPD/Mp7QSSOj+JEEYljDOCqs3G535AvF5vgbNLhumr
 M+P9qgSChrOKNpEatslpATR/w9Kz8qzNNaNd0gjEPejVRwGqQLyuX7M6bpYQ0+xoWc9iXrsz4
 +ouatYm54NQyi1jsrm0eivWQPBF/Wb9LHTmTxW/xOO9Dn/4m3EEH6JzNcT5YSaUtEQK01E+UB
 o/gltq99pPhROYHi4ldbg7gjdBmlWwLyQOwxvXluTGsMSfhK67k013Vg5xWchVmvR68kDP+ei
 M5ZAWtS5HQfsP8d3fk40FX8Bq1CEmUj7LlbCdXSlc73ZUq/U3goK8Jk6pi6nofA+xcCfnI75W
 rVjs9mRcwgMtWA=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order that the end of a clk_div_table can be detected, it must be
terminated with a sentinel element (.div =3D 0).

Fixes: b4626a7f4892 ("CLK: Add Loongson1C clock support")
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
=2D--

v4:
- remove trailing comma

v3:
- no changes

v2:
- Add Fixes and R-b tags
=2D--
 drivers/clk/loongson1/clk-loongson1c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/loongson1/clk-loongson1c.c b/drivers/clk/loongson=
1/clk-loongson1c.c
index 703f87622cf5f..1ebf740380efb 100644
=2D-- a/drivers/clk/loongson1/clk-loongson1c.c
+++ b/drivers/clk/loongson1/clk-loongson1c.c
@@ -37,6 +37,7 @@ static const struct clk_div_table ahb_div_table[] =3D {
 	[1] =3D { .val =3D 1, .div =3D 4 },
 	[2] =3D { .val =3D 2, .div =3D 3 },
 	[3] =3D { .val =3D 3, .div =3D 3 },
+	[4] =3D { /* sentinel */ }
 };

 void __init ls1x_clk_init(void)
=2D-
2.34.1

