Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A05D465EB5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 08:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345379AbhLBHck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 02:32:40 -0500
Received: from st43p00im-ztfb10071701.me.com ([17.58.63.173]:52771 "EHLO
        st43p00im-ztfb10071701.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238379AbhLBHcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 02:32:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1638430151; bh=KSVWAl5J+L7CAYIxSh1y9C3k9R9sIqe1hOj5vyjrZD4=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=Dk6T2cCDQcly0SYNloRyrflAcsaj35JukCc1XS/8TG7QXrTxYsHsG2VZZFhCX5P+e
         VVOP7Ck0g/Nnn/sX6i/VTh/onOcJCn+7Oe2oO54rGFykUFlgUU287FhXYkhRhVtAov
         mwDcxI99i9Z2mDn3aOxm++owKB1/oKsCGnftfn6TKLLvcB1YrB3JRr9P9g5WuVPFgo
         iPz4oh7VE0WpEhbj+RSwmGHKmqV+kfu++2L2ovD9en0GwjGN8QXgOYntM+ybu9Lj3g
         OXkreyu4EP5QLKoPHEtMSkQxxJLd+KF7KQHkSTbGt58ONVWa4QT99ZmZD6Jwrs2Dkd
         4bybJzJFdOwqw==
Received: from localhost (101.220.150.77.rev.sfr.net [77.150.220.101])
        by st43p00im-ztfb10071701.me.com (Postfix) with ESMTPSA id E69ED8A0373;
        Thu,  2 Dec 2021 07:29:08 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Alain Volmat <avolmat@me.com>
Subject: [PATCH 0/2] clk: st: update to avoid DT warnings
Date:   Thu,  2 Dec 2021 08:28:48 +0100
Message-Id: <20211202072850.194314-1-avolmat@me.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-12-01_01:2021-11-30,2021-11-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=614 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2112020043
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

Alain Volmat (2):
  clk: st: clkgen-fsyn: search reg within node or parent
  clk: st: clkgen-mux: search reg within node or parent

 drivers/clk/st/clkgen-fsyn.c | 11 +++++++++--
 drivers/clk/st/clkgen-mux.c  | 11 +++++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

-- 
2.25.1

