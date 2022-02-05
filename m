Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7A84AA825
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 11:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379732AbiBEKg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 05:36:57 -0500
Received: from mout.gmx.net ([212.227.17.20]:59957 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1379716AbiBEKgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 05:36:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644057403;
        bh=xpHPe4wIR1exAc1cF2StueHrTXV82PgtaxfrH2HYC4o=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=F1hcHNjBPdOpVMhHX4PX1sAeqOyqXU9N+j7+o9mtjqiyY/XlK9xY+7wG5kcX+CQx6
         /1o1YHFzv1DnCRzlA1qzSKoQAiK6jjRUG7xhsDzP/nPd1mCWwPpnBNvIdT6adUANza
         e9fhGgWsU//vRKXUpFwCgvw7WBm/bgjXkw/78Uks=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.160]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDQeU-1n5spZ3CXG-00AUFw; Sat, 05
 Feb 2022 11:36:43 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v2 5/7] clk: mmp: Declare mux tables as const u32[]
Date:   Sat,  5 Feb 2022 11:36:11 +0100
Message-Id: <20220205103613.1216218-6-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220205103613.1216218-1-j.neuschaefer@gmx.net>
References: <20220205103613.1216218-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:484u0cPlgTTPxmQUrE6UBAsd2xifETbVQ4jDXYSG2AA02TcLyJV
 Z/q57Lt5jzmjAdkR2wbfEQkUM9S64enKizCYuqklwVK/0dNMPL4S0qR5DSJ1OcQDjTWLaAU
 v+0DzGcQeZnvuJxJv2G99RLlE+3BPV1rv+4CD9akUp+84V7wuT3VM+zpC4UNWUs4TFJXUdj
 ToD2UjzJ5L09A2Ty1Qr0Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ETKSHt9upWg=:8XbqSvp38n2FkdeyGwyqZD
 zKmIRWZfBP0x47TbvBruXGep7rUYFPeC4pbc17AKPja39KK4SxupERoF6xZooLulqX0iiCbnl
 6DIVtQMoUyY+VH3Fl1TVJAwEyeSfGx3HKFffSESTb+SJcl3XpGdCQmXLGHlGFhZt12KSPoRX8
 82lLwkAkYnDzbTdeC4Km2Qp8EGSbNwNxqkzDvhbA9ZAdExgeEV2eGZfQ2KyJiHmL/epDFzGIM
 VUCf2Kh5q6s0S3oyXggmzV+Fi77qIpNNfm7ZYfeeF5e5aTI7fdOYvSmgnx/HcxzEY3Rp8rDm9
 fc4sCGgNet30yfHKT3rFzvYBcMISd2X/Go5R5q50aBM5pMmyc87p7ioQgKCAxvAd5dkNAFeTx
 6RI87k+MBX9Km/insGWkQMUn4iNoEsQPh9XV9zBkRUsAJB4qlhNjvLTtDYC4H57zDvS6R9mW0
 buPClkgkF+sGXUL/m+C1Zg/Sl7Z95yllRFQDJU9AR232upO0gv4NMAS5ROATMCPNo6DsshWC4
 VrhBof7E6fxjeV/CKFsojOBF5TIyV/T5Hx+QB1KyiHzz3eo3KVP4QWSjy/lVF2Jl7hyScKmCs
 n9fwVi3a7ghv2gtPBM6NyaE0aSeUFsimK8ZpShhM09aZjfUN1PHzIbdE+Gfu6LA28dM2GQW71
 b7iEY0/vZUFw/ftpZS4t9CoYRFfX7C+PIPllhECmZeeeKB6w3UmgoW3kcGiW89LShrnFFSjwy
 26JOqX14Qy9qyhuW/HRWDtaUMbJjDqYeX04SbxUM+C02XgJFOCSFFys2S5gh32AXrSoGvBMfh
 jlvAvtR5q77D36PL453WlNYLuEPV2cczfvWqsf88C/OxXFv118X0bNGi2JIGC+wSejLM+jN2j
 DcwpSAvefsBNrOT4HBYfaXAlCDd8nNlkufQ/nV/huDRccM4mhUV2f/ZlZPGxChuS6maB0+EtZ
 xGik6iahSTO39XvRSqoU6AYg46I86rf+T+QcoaObX/JAcVCGXMok9Mr3k9dbBU3gpQPszpIUE
 IuoIAXTNSrG5U91PePH+PU4F7Gu2EG5W5MzKhSmMG91SJR+nhGzCGtfkdfk3DcK7+Tu7pfWuy
 vbCCcpDyU9Nr6Q=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that clk_register_mux_table takes a const u32 *, we can declare the
mux tables as const u32[].

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--

v2:
- no changes
=2D--
 drivers/clk/mmp/clk-of-mmp2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mmp/clk-of-mmp2.c b/drivers/clk/mmp/clk-of-mmp2.c
index 0839fb2049e94..50a780274ba0c 100644
=2D-- a/drivers/clk/mmp/clk-of-mmp2.c
+++ b/drivers/clk/mmp/clk-of-mmp2.c
@@ -317,9 +317,9 @@ static const char * const ccic_parent_names[] =3D {"pl=
l1_2", "pll1_16", "vctcxo"};

 static DEFINE_SPINLOCK(gpu_lock);
 static const char * const mmp2_gpu_gc_parent_names[] =3D  {"pll1_2", "pll=
1_3", "pll2_2", "pll2_3", "pll2", "usb_pll"};
-static u32 mmp2_gpu_gc_parent_table[] =3D          { 0x0000,   0x0040,   =
0x0080,   0x00c0,   0x1000, 0x1040   };
+static const u32 mmp2_gpu_gc_parent_table[] =3D { 0x0000,   0x0040,   0x0=
080,   0x00c0,   0x1000, 0x1040   };
 static const char * const mmp2_gpu_bus_parent_names[] =3D {"pll1_4", "pll=
2",   "pll2_2", "usb_pll"};
-static u32 mmp2_gpu_bus_parent_table[] =3D         { 0x0000,   0x0020,   =
0x0030,   0x4020   };
+static const u32 mmp2_gpu_bus_parent_table[] =3D { 0x0000,   0x0020,   0x=
0030,   0x4020   };
 static const char * const mmp3_gpu_bus_parent_names[] =3D {"pll1_4", "pll=
1_6", "pll1_2", "pll2_2"};
 static const char * const mmp3_gpu_gc_parent_names[] =3D  {"pll1",   "pll=
2",   "pll1_p", "pll2_p"};

=2D-
2.34.1

