Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339C24BAE09
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiBRAKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 19:10:04 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiBRAKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 19:10:03 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F3753B46;
        Thu, 17 Feb 2022 16:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645142966;
        bh=IUY/Y8Yalj5BX0e49AhUG8NejOzNrCeKKECRLd/cfB0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=g9t0/AtHqGQeNCOHRCB1iLtdV7W+jIgwKvpWXnn4VAaGn53Q+XnyM8NF/GrRhngfz
         w7vnf9MOomInAvIRDPmNPydwle2NUN8I99hh5sOit2QJt4qIwgTfA3lVaIRE4rlrQS
         51uOVIiozDxeN4+lgawL/RH7PuOwZ5EKPmTO3PUg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtOGa-1o7bPE27uo-00uo9K; Fri, 18
 Feb 2022 01:09:26 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH v4 0/5] clk drivers: Terminate clk_div_table with sentinel element
Date:   Fri, 18 Feb 2022 01:09:16 +0100
Message-Id: <20220218000922.134857-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SwIrvdnd0sbyaueb09YuSqV9exkrua/1OLLW1xmo5FZXWsJlJ4C
 0z1YzQNkcy/0Mnt1W7+xQVgNWsCI6GPXEtLKMUqA/ZuozNakH/uO0vTaV7ZlFPE0lwEkCbR
 sJTq8c0117HHNiI7dvTgKyG62lUPmOySRhWRv33FS0M6xaGzLkV8x8aUo8PH/izU+l5rezL
 zddUvNna+4bGA2EGZtF9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J04z+bzVdxI=:sjCHMbAhVUxarWqNKdoWWO
 briPaCEnwjbYO9upMLl6Lr+yW6Bm0cSA9DEQrcVYwP0PJ8vPpoNqsKNXYa4esIBYt+V3sEjmP
 9ez7fu0Be6vry5zGQLAEgeAoZyhbMK5EmV/WiTKXxodJWjLusVBa5R5QP9zA6dOntGHpoQRN7
 3VaSdBywx3FWY3Te+1OQpwndImPHXgFB/AWow5ZJPeC4cvV7G1L2QIOmgC/Qhz77C0UNCNedq
 SEEHyA/eFiSkwU3ntXSm78w0UXFwpiJQaqCnIeOqFEXudtV/BTbN9F5Hxi2WZ9YupeZCMRNJz
 rwDBNChhKMONCFMCAaoaW3QYSiKw3sYWqXFUYSVeKYRr0i87h3A6Gq6WX8vFhcl0IRuuNSGsB
 hivQnQ46QmkyRpgn2VKnPV+x5/kqWfuUcpL9J8jJDq8OCx0ii9Z9YKQhDvjPOxk04bqxAYmIC
 0WPYFUCxe5k6w6IAg2cIexUmgpPY+eZJzxsb68d2a4inTcbZSCZUh1tCijxSthbopre4TH9pY
 PnHXoY0wfzyqB+TnhD0KNZAKyV2QKKQ8dSG6uV/c3shh6MiYBCL3jSqglwSAGPunv7MucsfcR
 nlJXcQzZtGULTMudQhTh4dT9EhmFdMi4qm5vMeGuUip9KmYVwIDLNCHit/vRatpJQyev9xNam
 E055/c98Im6fhQlmWeUhSlN0V6YJh/OAELZ/EBefiO6EkQiKlbbiIBrV/d7si0v18sgUwBWpF
 X0GsFqZmdoK/kFWfpAXHyGKF335B0QAcqpjt9orLwTWUjPBbp5H5Y00IsRLr34WT8O4ZNz+YV
 AtAzSUau05EZCYmxnQ7NNDPaJkweSQD5tfHZP9GRY6EjltUZlqkq1f7dQlM4vavJdh6rCUyIZ
 VpVXpvZEZzKlXLkJX6QCyrZEXIyrG4bMkkard/j37lzm6k2ayvWDyHP8yeFPu0XF+1ZIG9I41
 QQv9TBYojHETIF68kGBtTWNxMVj6peSdaXjO5rX5h8M57MauxgYUx5UmiifGt7kkR31RMNIpY
 QdKSuYIdqEfpAWkWka1LYNRRx/JwVhQELIXo0gnko4sfSNHW83yBhv+rhVEKCBB8kaiAJitwT
 pIwLWpUygqmi78=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed that some of the clk_div_tables in different drivers are not
terminated with a sentinel element. This may cause the code in
clk-divider.c to read garbage that happens to be beyond the end.

This patchset fixed all instances of this bug that I could find, except
for a case in drivers/phy/ti/phy-j721e-wiz.c that is already fixed in
linux-next:
  https://lore.kernel.org/lkml/20220117110108.4117-1-kishon@ti.com/

In this version of the patchset, I addressed Philippe Mathieu-Daud=C3=A9's
style comments. As far as I found it reasonable, I simply updated the
existing patches, but in the case of the Actions Semiconductor drivers,
I made a bigger cleanup in a separate patch.


v4:
- Various style fixes

v3:
- Change the Actions patch according to Mani's comment

v2:
- Add Fixes tags


Jonathan Neusch=C3=A4fer (5):
  clk: actions: Terminate clk_div_table with sentinel element
  clk: loongson1: Terminate clk_div_table with sentinel element
  clk: hisilicon: Terminate clk_div_table with sentinel element
  clk: clps711x: Terminate clk_div_table with sentinel element
  clk: actions: Make sentinel elements more obvious

 drivers/clk/actions/owl-s500.c         | 16 ++++++++--------
 drivers/clk/actions/owl-s700.c         | 17 ++++++++++-------
 drivers/clk/actions/owl-s900.c         | 26 +++++++++++++-------------
 drivers/clk/clk-clps711x.c             |  2 ++
 drivers/clk/hisilicon/clk-hi3559a.c    |  4 ++--
 drivers/clk/loongson1/clk-loongson1c.c |  1 +
 6 files changed, 36 insertions(+), 30 deletions(-)

=2D-
2.34.1

