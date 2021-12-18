Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166E7479CB9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 22:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbhLRVMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 16:12:41 -0500
Received: from st43p00im-ztfb10063301.me.com ([17.58.63.179]:55514 "EHLO
        st43p00im-ztfb10063301.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234222AbhLRVMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 16:12:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1639861960; bh=y1Q4So049yY6R/vuf+Xi1DcTVKT0QzoZ7rCKMVlWz0s=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=jZObGqznkU6EM8+xJ1gdnGbLADC5MC6RVoYsfiVuQTyVMBfAcXJxTQPb79/sXDQaP
         kAnJb0KJKjybiPsdyXce7+5Z1v9SEvuOBk8uWZicw6wYohi1guIbiUr5P8B/Em9YA6
         Isa5xEWJi4ofup1cN1WQwz8FrdG1J+Zftwr4cEA59WoN6jzB87LI3/dlkmNAeNLoHa
         mPrHrHxZkmRaHuNFaJ8Cx8+W/16pJLbK1DCVnWmSFOXYQTDQX4BjwUwRbvSwqsE+pg
         xOTHL9heqWKhZGnFreqXlyxC/Os5YSuRw0xJqqGOyiJszAENTBW5YHmycBpv8VqyuG
         4xFRJ2sc+hgtQ==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztfb10063301.me.com (Postfix) with ESMTPSA id 356F0A40137;
        Sat, 18 Dec 2021 21:12:38 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Alain Volmat <avolmat@me.com>
Subject: [PATCH v2 0/2] clk: st: update to avoid DT warnings
Date:   Sat, 18 Dec 2021 22:11:55 +0100
Message-Id: <20211218211157.188214-1-avolmat@me.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-12-18_08:2021-12-15,2021-12-18 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=560 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2112180129
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The serie contains 2 updates within clkgen-fsyn and clkgen-mux
in order to allow those drivers to pick up the reg property
within their parent node instead of their own node.  Such
behavior is already in place for the other st clk drivers and
to allow to not have several time the same reg value within
the device tree.
Those changes are also done in order to avoid DT warning seen
when compiling with W=1 and indicating unique-unit-address issues.

v2: update clkgen-fsyn patch to add a pr_err

Alain Volmat (2):
  clk: st: clkgen-fsyn: search reg within node or parent
  clk: st: clkgen-mux: search reg within node or parent

 drivers/clk/st/clkgen-fsyn.c | 13 +++++++++++--
 drivers/clk/st/clkgen-mux.c  | 11 +++++++++--
 2 files changed, 20 insertions(+), 4 deletions(-)

-- 
2.25.1

