Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF934BAE31
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiBRAKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 19:10:31 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiBRAK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 19:10:29 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E82A58397;
        Thu, 17 Feb 2022 16:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645142976;
        bh=dzJiVygOZA/XkFKLwsRSgIaENO2Mjx5mqLbH784YinQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=FCjYPrjopSOTOkN5xkyxo4aMsaqyGSRWBJdVLSZOLMXWhQNGuzqE4ny9YAGF7s1gk
         /SFkKGh0Po6Pe5tnDfcQWbqpS6TovJUR54TWSr1sHHbeCq0DOmFG90hGcH7/yQAh7b
         4GHhNfgcy/dCF3zGZvKW5qq5KrGZohHMIY88PM0w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MD9X9-1nTtGT0vTt-009Cyg; Fri, 18
 Feb 2022 01:09:36 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dongjiu Geng <gengdongjiu@huawei.com>
Subject: [PATCH v4 3/5] clk: hisilicon: Terminate clk_div_table with sentinel element
Date:   Fri, 18 Feb 2022 01:09:19 +0100
Message-Id: <20220218000922.134857-4-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218000922.134857-1-j.neuschaefer@gmx.net>
References: <20220218000922.134857-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:96xUFhBHPOxIo5rsl7aBIDVboX7ATG6jjQOvUnqABAZuh+GTOdX
 8dHXnASXn6cdEmpIzWVB9KiGlYMZs8v/KXblu7IfthqQKw0zC9ZkRaKpFEQITYz8Vd5PXqi
 yNPTcZU2mkWfvM8h746o8fOxWR+yA43l6owwHTDU7PCnx+kNNd2UTMqhXHjF3qsdI9h5vv0
 iKxkTpKL2eK8GUu/vKlhA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ql56313tolk=:Wc9bpvNMS3EcswujPVJEIN
 1EAiSU9uhRJH9Gra1G+hprLiZ31XYGylZGDcD4PiqvxXvH5xDnL1wZWvREidCkUt/8uF8ZFc8
 vdi+7BGzI7INCxGhGeZIBMkRF7n6UtgXIVP2WRWbhWgJH/qhyX/f9V73502HJjkCHsBQUSlKa
 OfuRAW51ROKeTv81HSEFnaH9IG3d20THDv6c9FLmwTy0Jc6RrImgk2gArGtUFbVrqoUhaxZ3V
 HndtmWSJ2UdFKZCqNO9fGLmgASdlOgI0OyQRxlbP6b9PRIhSIx3GPcrDQurftqdsYgBb7QIpH
 qIjdeC5K2u3//RFe1kJ7MbK0ZbqyXuJyh5wl35rZCumW+5tMHkn20oi10Ygpoihb97tW6uVRT
 zj+jM4jt7hYDbFF7qEXplRdwxHAOZ+lyFcE3SglCYD9Q58KuFLo3oMtwxwucBRm9o7GLoNO++
 WIA90P8t9FvDJnAOL7uLXbbmh6w1OKf8ohC1cav2WFNT23/I9sYErNryZTNYzRDRM0ReE8Tfg
 claIFk1DKNfvB0xvtGxfwRqWRC7Zvy2/3Hx1TldCQOG4rtG6kX+JZ2ygeBKG+8k0ZFRyzB2u2
 zQuvKtuXbZqeN/EHgLoO4mkyk72XcbuBu+LExrwS/Lclz+iQ/pahiUxOolkZW9B0BnR6LVXa4
 NHg5B6SXlO3JA6JhUV2tQhf0hsELDcTMihCQ8SU8IU4RJj03A6iWUo24P4BeflctxgomvlycL
 xeSJROfUs/yQJPVm0qcf1DTq8aZLG/J/rQVxWGwGvBMy8PJjfZUHGHCbGKACX1S8uay66PY5g
 FYwQ8n6ma0STPAlqaCrae4XXFI67Epzot3LuuZFYFzGeZcx9pMIAsnxHXFMqOzX0WQYA4Eytg
 jexRLxH6YIt67hAjYWNmtB5yqaBQhduXclfYNcl56Gi4pW8CFjsb4ccWzowagOyo1HVWUtpx/
 afcMEQKGuhe7YeIll9e3AtQ9WryazgSjDFPvTIdIaYpsaMNQ1f7+936rPVQhoqBQL03FtoiiL
 Fsi5HqeaS+j17U+E2DDlVocvACQ3/+82Y2QJpHdyx3IgaF0EgRsvRtY1SOe1ApIZLZIQcz4RH
 o3r/3cKV3JxE7k=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order that the end of a clk_div_table can be detected, it must be
terminated with a sentinel element (.div =3D 0).

Fixes: 6c81966107dc0 ("clk: hisilicon: Add clock driver for hi3559A SoC")
Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v4:
- add /* sentinel */ comment into sentinel element

v3:
- no changes

v2:
- Add Fixes tag
=2D--
 drivers/clk/hisilicon/clk-hi3559a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3559a.c b/drivers/clk/hisilicon/c=
lk-hi3559a.c
index 56012a3d02192..9ea1a80acbe8b 100644
=2D-- a/drivers/clk/hisilicon/clk-hi3559a.c
+++ b/drivers/clk/hisilicon/clk-hi3559a.c
@@ -611,8 +611,8 @@ static struct hisi_mux_clock hi3559av100_shub_mux_clks=
[] =3D {


 /* shub div clk */
-static struct clk_div_table shub_spi_clk_table[] =3D {{0, 8}, {1, 4}, {2,=
 2}};
-static struct clk_div_table shub_uart_div_clk_table[] =3D {{1, 8}, {2, 4}=
};
+static struct clk_div_table shub_spi_clk_table[] =3D {{0, 8}, {1, 4}, {2,=
 2}, {/*sentinel*/}};
+static struct clk_div_table shub_uart_div_clk_table[] =3D {{1, 8}, {2, 4}=
, {/*sentinel*/}};

 static struct hisi_divider_clock hi3559av100_shub_div_clks[] =3D {
 	{ HI3559AV100_SHUB_SPI_SOURCE_CLK, "clk_spi_clk", "shub_clk", 0, 0x20, 2=
4, 2,
=2D-
2.34.1

