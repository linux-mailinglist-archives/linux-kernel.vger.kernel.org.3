Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E7E5483E3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 12:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241120AbiFMJt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 05:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240560AbiFMJsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 05:48:11 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0111919C2D;
        Mon, 13 Jun 2022 02:48:09 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LM6C74m1KzgYqT;
        Mon, 13 Jun 2022 17:46:11 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 17:48:07 +0800
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 17:48:06 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [RFC 08/13] perf kwork: Add softirq report support
Date:   Mon, 13 Jun 2022 17:46:00 +0800
Message-ID: <20220613094605.208401-9-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
In-Reply-To: <20220613094605.208401-1-yangjihong1@huawei.com>
References: <20220613094605.208401-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.61]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implements softirq kwork report function.

test case:

  # perf kwork rep

    Kwork Name                | Cpu  | Total Runtime | Frequency | Max runtime   | Max runtime start   | Max runtime end     |
   ---------------------------------------------------------------------------------------------------------------------------
    virtio0-requests:25       | 0000 |   1073.208 ms |     19333 |      1.331 ms |    2059360.096926 s |    2059360.098257 s |
    (s)RCU:9                  | 0001 |    169.534 ms |      3156 |      1.435 ms |    2059361.588639 s |    2059361.590074 s |
    (s)TIMER:1                | 0003 |    150.007 ms |      2472 |      0.125 ms |    2059359.989698 s |    2059359.989823 s |
    (s)RCU:9                  | 0007 |     90.461 ms |      1578 |      0.978 ms |    2059362.073209 s |    2059362.074187 s |
    (s)SCHED:7                | 0007 |     81.408 ms |      1984 |      1.120 ms |    2059358.259073 s |    2059358.260193 s |
    (s)SCHED:7                | 0001 |     49.071 ms |      1148 |      0.090 ms |    2059364.592682 s |    2059364.592772 s |
    (s)RCU:9                  | 0003 |     41.725 ms |      1823 |      0.087 ms |    2059358.201654 s |    2059358.201742 s |
    (s)SCHED:7                | 0003 |     27.001 ms |       629 |      0.116 ms |    2059358.207263 s |    2059358.207379 s |
    (s)SCHED:7                | 0000 |     25.318 ms |       232 |      1.490 ms |    2059361.310045 s |    2059361.311535 s |
    (s)RCU:9                  | 0004 |     10.983 ms |        94 |      0.981 ms |    2059358.241061 s |    2059358.242042 s |
    (s)RCU:9                  | 0000 |      3.102 ms |        66 |      1.568 ms |    2059360.853075 s |    2059360.854643 s |
    (s)TIMER:1                | 0001 |      2.207 ms |        27 |      0.108 ms |    2059363.117923 s |    2059363.118031 s |
    (s)NET_RX:3               | 0002 |      1.065 ms |         6 |      0.903 ms |    2059359.985888 s |    2059359.986792 s |
    (s)TIMER:1                | 0007 |      0.740 ms |         6 |      0.192 ms |    2059368.237655 s |    2059368.237847 s |
    (s)RCU:9                  | 0005 |      0.715 ms |        18 |      0.098 ms |    2059360.002711 s |    2059360.002810 s |
    (s)TIMER:1                | 0000 |      0.704 ms |         7 |      0.130 ms |    2059360.850686 s |    2059360.850816 s |
    (s)TIMER:1                | 0002 |      0.688 ms |         7 |      0.131 ms |    2059368.237258 s |    2059368.237389 s |
    (s)SCHED:7                | 0002 |      0.637 ms |         9 |      0.177 ms |    2059362.689653 s |    2059362.689830 s |
    (s)BLOCK:4                | 0007 |      0.586 ms |         4 |      0.174 ms |    2059362.620644 s |    2059362.620818 s |
    (s)TIMER:1                | 0005 |      0.414 ms |         1 |      0.414 ms |    2059361.265364 s |    2059361.265778 s |
    (s)SCHED:7                | 0005 |      0.406 ms |         7 |      0.078 ms |    2059361.265799 s |    2059361.265878 s |
    (s)SCHED:7                | 0004 |      0.237 ms |         4 |      0.084 ms |    2059368.376924 s |    2059368.377008 s |
    ata_piix:14               | 0002 |      0.221 ms |         4 |      0.096 ms |    2059362.610172 s |    2059362.610267 s |
    (s)RCU:9                  | 0002 |      0.208 ms |         9 |      0.030 ms |    2059359.279854 s |    2059359.279884 s |
    (s)TIMER:1                | 0004 |      0.199 ms |         1 |      0.199 ms |    2059362.605271 s |    2059362.605471 s |
    (s)TIMER:1                | 0006 |      0.196 ms |         2 |      0.108 ms |    2059358.207823 s |    2059358.207931 s |
    (s)RCU:9                  | 0006 |      0.150 ms |         4 |      0.077 ms |    2059358.209321 s |    2059358.209398 s |
    eth0:10                   | 0002 |      0.124 ms |         6 |      0.024 ms |    2059359.985835 s |    2059359.985859 s |
    (s)SCHED:7                | 0006 |      0.046 ms |         1 |      0.046 ms |    2059360.046630 s |    2059360.046676 s |
   ---------------------------------------------------------------------------------------------------------------------------
    INFO: 0.003% skipped events (3 including 0 entry, 3 exit)

  # perf kwork -k softirq rep

    Kwork Name                | Cpu  | Total Runtime | Frequency | Max runtime   | Max runtime start   | Max runtime end     |
   ---------------------------------------------------------------------------------------------------------------------------
    (s)RCU:9                  | 0001 |    169.534 ms |      3156 |      1.435 ms |    2059361.588639 s |    2059361.590074 s |
    (s)TIMER:1                | 0003 |    150.007 ms |      2472 |      0.125 ms |    2059359.989698 s |    2059359.989823 s |
    (s)RCU:9                  | 0007 |     90.461 ms |      1578 |      0.978 ms |    2059362.073209 s |    2059362.074187 s |
    (s)SCHED:7                | 0007 |     81.408 ms |      1984 |      1.120 ms |    2059358.259073 s |    2059358.260193 s |
    (s)SCHED:7                | 0001 |     49.071 ms |      1148 |      0.090 ms |    2059364.592682 s |    2059364.592772 s |
    (s)RCU:9                  | 0003 |     41.725 ms |      1823 |      0.087 ms |    2059358.201654 s |    2059358.201742 s |
    (s)SCHED:7                | 0003 |     27.001 ms |       629 |      0.116 ms |    2059358.207263 s |    2059358.207379 s |
    (s)SCHED:7                | 0000 |     25.318 ms |       232 |      1.490 ms |    2059361.310045 s |    2059361.311535 s |
    (s)RCU:9                  | 0004 |     10.983 ms |        94 |      0.981 ms |    2059358.241061 s |    2059358.242042 s |
    (s)RCU:9                  | 0000 |      3.102 ms |        66 |      1.568 ms |    2059360.853075 s |    2059360.854643 s |
    (s)TIMER:1                | 0001 |      2.207 ms |        27 |      0.108 ms |    2059363.117923 s |    2059363.118031 s |
    (s)NET_RX:3               | 0002 |      1.065 ms |         6 |      0.903 ms |    2059359.985888 s |    2059359.986792 s |
    (s)TIMER:1                | 0007 |      0.740 ms |         6 |      0.192 ms |    2059368.237655 s |    2059368.237847 s |
    (s)RCU:9                  | 0005 |      0.715 ms |        18 |      0.098 ms |    2059360.002711 s |    2059360.002810 s |
    (s)TIMER:1                | 0000 |      0.704 ms |         7 |      0.130 ms |    2059360.850686 s |    2059360.850816 s |
    (s)TIMER:1                | 0002 |      0.688 ms |         7 |      0.131 ms |    2059368.237258 s |    2059368.237389 s |
    (s)SCHED:7                | 0002 |      0.637 ms |         9 |      0.177 ms |    2059362.689653 s |    2059362.689830 s |
    (s)BLOCK:4                | 0007 |      0.586 ms |         4 |      0.174 ms |    2059362.620644 s |    2059362.620818 s |
    (s)TIMER:1                | 0005 |      0.414 ms |         1 |      0.414 ms |    2059361.265364 s |    2059361.265778 s |
    (s)SCHED:7                | 0005 |      0.406 ms |         7 |      0.078 ms |    2059361.265799 s |    2059361.265878 s |
    (s)SCHED:7                | 0004 |      0.237 ms |         4 |      0.084 ms |    2059368.376924 s |    2059368.377008 s |
    (s)RCU:9                  | 0002 |      0.208 ms |         9 |      0.030 ms |    2059359.279854 s |    2059359.279884 s |
    (s)TIMER:1                | 0004 |      0.199 ms |         1 |      0.199 ms |    2059362.605271 s |    2059362.605471 s |
    (s)TIMER:1                | 0006 |      0.196 ms |         2 |      0.108 ms |    2059358.207823 s |    2059358.207931 s |
    (s)RCU:9                  | 0006 |      0.150 ms |         4 |      0.077 ms |    2059358.209321 s |    2059358.209398 s |
    (s)SCHED:7                | 0006 |      0.046 ms |         1 |      0.046 ms |    2059360.046630 s |    2059360.046676 s |
   ---------------------------------------------------------------------------------------------------------------------------
    INFO: 0.003% skipped events (3 including 0 entry, 3 exit)

  # perf kwork -k softirq rep -C 0,2

    Kwork Name                | Cpu  | Total Runtime | Frequency | Max runtime   | Max runtime start   | Max runtime end     |
   ---------------------------------------------------------------------------------------------------------------------------
    (s)SCHED:7                | 0000 |     25.318 ms |       232 |      1.490 ms |    2059361.310045 s |    2059361.311535 s |
    (s)RCU:9                  | 0000 |      3.102 ms |        66 |      1.568 ms |    2059360.853075 s |    2059360.854643 s |
    (s)NET_RX:3               | 0002 |      1.065 ms |         6 |      0.903 ms |    2059359.985888 s |    2059359.986792 s |
    (s)TIMER:1                | 0000 |      0.704 ms |         7 |      0.130 ms |    2059360.850686 s |    2059360.850816 s |
    (s)TIMER:1                | 0002 |      0.688 ms |         7 |      0.131 ms |    2059368.237258 s |    2059368.237389 s |
    (s)SCHED:7                | 0002 |      0.637 ms |         9 |      0.177 ms |    2059362.689653 s |    2059362.689830 s |
    (s)RCU:9                  | 0002 |      0.208 ms |         9 |      0.030 ms |    2059359.279854 s |    2059359.279884 s |
   ---------------------------------------------------------------------------------------------------------------------------

  # perf kwork -k softirq rep -n RCU

    Kwork Name                | Cpu  | Total Runtime | Frequency | Max runtime   | Max runtime start   | Max runtime end     |
   ---------------------------------------------------------------------------------------------------------------------------
    (s)RCU:9                  | 0001 |    169.534 ms |      3156 |      1.435 ms |    2059361.588639 s |    2059361.590074 s |
    (s)RCU:9                  | 0007 |     90.461 ms |      1578 |      0.978 ms |    2059362.073209 s |    2059362.074187 s |
    (s)RCU:9                  | 0003 |     41.725 ms |      1823 |      0.087 ms |    2059358.201654 s |    2059358.201742 s |
    (s)RCU:9                  | 0004 |     10.983 ms |        94 |      0.981 ms |    2059358.241061 s |    2059358.242042 s |
    (s)RCU:9                  | 0000 |      3.102 ms |        66 |      1.568 ms |    2059360.853075 s |    2059360.854643 s |
    (s)RCU:9                  | 0005 |      0.715 ms |        18 |      0.098 ms |    2059360.002711 s |    2059360.002810 s |
    (s)RCU:9                  | 0002 |      0.208 ms |         9 |      0.030 ms |    2059359.279854 s |    2059359.279884 s |
    (s)RCU:9                  | 0006 |      0.150 ms |         4 |      0.077 ms |    2059358.209321 s |    2059358.209398 s |
   ---------------------------------------------------------------------------------------------------------------------------
    INFO: 0.001% skipped events (1 including 0 entry, 1 exit)

  # perf kwork -k softirq rep -s max,freq

    Kwork Name                | Cpu  | Total Runtime | Frequency | Max runtime   | Max runtime start   | Max runtime end     |
   ---------------------------------------------------------------------------------------------------------------------------
    (s)RCU:9                  | 0000 |      3.102 ms |        66 |      1.568 ms |    2059360.853075 s |    2059360.854643 s |
    (s)SCHED:7                | 0000 |     25.318 ms |       232 |      1.490 ms |    2059361.310045 s |    2059361.311535 s |
    (s)RCU:9                  | 0001 |    169.534 ms |      3156 |      1.435 ms |    2059361.588639 s |    2059361.590074 s |
    (s)SCHED:7                | 0007 |     81.408 ms |      1984 |      1.120 ms |    2059358.259073 s |    2059358.260193 s |
    (s)RCU:9                  | 0004 |     10.983 ms |        94 |      0.981 ms |    2059358.241061 s |    2059358.242042 s |
    (s)RCU:9                  | 0007 |     90.461 ms |      1578 |      0.978 ms |    2059362.073209 s |    2059362.074187 s |
    (s)NET_RX:3               | 0002 |      1.065 ms |         6 |      0.903 ms |    2059359.985888 s |    2059359.986792 s |
    (s)TIMER:1                | 0005 |      0.414 ms |         1 |      0.414 ms |    2059361.265364 s |    2059361.265778 s |
    (s)TIMER:1                | 0004 |      0.199 ms |         1 |      0.199 ms |    2059362.605271 s |    2059362.605471 s |
    (s)TIMER:1                | 0007 |      0.740 ms |         6 |      0.192 ms |    2059368.237655 s |    2059368.237847 s |
    (s)SCHED:7                | 0002 |      0.637 ms |         9 |      0.177 ms |    2059362.689653 s |    2059362.689830 s |
    (s)BLOCK:4                | 0007 |      0.586 ms |         4 |      0.174 ms |    2059362.620644 s |    2059362.620818 s |
    (s)TIMER:1                | 0002 |      0.688 ms |         7 |      0.131 ms |    2059368.237258 s |    2059368.237389 s |
    (s)TIMER:1                | 0000 |      0.704 ms |         7 |      0.130 ms |    2059360.850686 s |    2059360.850816 s |
    (s)TIMER:1                | 0003 |    150.007 ms |      2472 |      0.125 ms |    2059359.989698 s |    2059359.989823 s |
    (s)SCHED:7                | 0003 |     27.001 ms |       629 |      0.116 ms |    2059358.207263 s |    2059358.207379 s |
    (s)TIMER:1                | 0001 |      2.207 ms |        27 |      0.108 ms |    2059363.117923 s |    2059363.118031 s |
    (s)TIMER:1                | 0006 |      0.196 ms |         2 |      0.108 ms |    2059358.207823 s |    2059358.207931 s |
    (s)RCU:9                  | 0005 |      0.715 ms |        18 |      0.098 ms |    2059360.002711 s |    2059360.002810 s |
    (s)SCHED:7                | 0001 |     49.071 ms |      1148 |      0.090 ms |    2059364.592682 s |    2059364.592772 s |
    (s)RCU:9                  | 0003 |     41.725 ms |      1823 |      0.087 ms |    2059358.201654 s |    2059358.201742 s |
    (s)SCHED:7                | 0004 |      0.237 ms |         4 |      0.084 ms |    2059368.376924 s |    2059368.377008 s |
    (s)SCHED:7                | 0005 |      0.406 ms |         7 |      0.078 ms |    2059361.265799 s |    2059361.265878 s |
    (s)RCU:9                  | 0006 |      0.150 ms |         4 |      0.077 ms |    2059358.209321 s |    2059358.209398 s |
    (s)SCHED:7                | 0006 |      0.046 ms |         1 |      0.046 ms |    2059360.046630 s |    2059360.046676 s |
    (s)RCU:9                  | 0002 |      0.208 ms |         9 |      0.030 ms |    2059359.279854 s |    2059359.279884 s |
   ---------------------------------------------------------------------------------------------------------------------------
    INFO: 0.003% skipped events (3 including 0 entry, 3 exit)

  # perf kwork -k softirq rep --time 2059361,

    Kwork Name                | Cpu  | Total Runtime | Frequency | Max runtime   | Max runtime start   | Max runtime end     |
   ---------------------------------------------------------------------------------------------------------------------------
    (s)RCU:9                  | 0001 |    148.655 ms |      2838 |      1.435 ms |    2059361.588639 s |    2059361.590074 s |
    (s)TIMER:1                | 0003 |    109.877 ms |      1811 |      0.121 ms |    2059361.071163 s |    2059361.071284 s |
    (s)SCHED:7                | 0001 |     48.681 ms |      1140 |      0.090 ms |    2059364.592682 s |    2059364.592772 s |
    (s)SCHED:7                | 0007 |     32.373 ms |       796 |      0.808 ms |    2059361.088583 s |    2059361.089391 s |
    (s)RCU:9                  | 0003 |     30.198 ms |      1327 |      0.045 ms |    2059363.891611 s |    2059363.891655 s |
    (s)RCU:9                  | 0007 |     28.735 ms |       524 |      0.978 ms |    2059362.073209 s |    2059362.074187 s |
    (s)SCHED:7                | 0003 |     19.399 ms |       457 |      0.055 ms |    2059367.528239 s |    2059367.528295 s |
    (s)SCHED:7                | 0000 |     14.284 ms |       143 |      1.490 ms |    2059361.310045 s |    2059361.311535 s |
    (s)TIMER:1                | 0001 |      1.716 ms |        21 |      0.108 ms |    2059363.117923 s |    2059363.118031 s |
    (s)RCU:9                  | 0004 |      1.061 ms |        10 |      0.766 ms |    2059368.385058 s |    2059368.385824 s |
    (s)RCU:9                  | 0000 |      1.001 ms |        43 |      0.043 ms |    2059364.147987 s |    2059364.148031 s |
    (s)SCHED:7                | 0002 |      0.591 ms |         8 |      0.177 ms |    2059362.689653 s |    2059362.689830 s |
    (s)BLOCK:4                | 0007 |      0.586 ms |         4 |      0.174 ms |    2059362.620644 s |    2059362.620818 s |
    (s)TIMER:1                | 0002 |      0.578 ms |         6 |      0.131 ms |    2059368.237258 s |    2059368.237389 s |
    (s)TIMER:1                | 0007 |      0.491 ms |         4 |      0.192 ms |    2059368.237655 s |    2059368.237847 s |
    (s)TIMER:1                | 0000 |      0.485 ms |         5 |      0.122 ms |    2059366.586542 s |    2059366.586665 s |
    (s)TIMER:1                | 0005 |      0.414 ms |         1 |      0.414 ms |    2059361.265364 s |    2059361.265778 s |
    (s)SCHED:7                | 0004 |      0.199 ms |         3 |      0.084 ms |    2059368.376924 s |    2059368.377008 s |
    (s)TIMER:1                | 0004 |      0.199 ms |         1 |      0.199 ms |    2059362.605271 s |    2059362.605471 s |
    (s)SCHED:7                | 0005 |      0.185 ms |         3 |      0.078 ms |    2059361.265799 s |    2059361.265878 s |
    (s)RCU:9                  | 0002 |      0.132 ms |         6 |      0.023 ms |    2059367.469375 s |    2059367.469398 s |
    (s)RCU:9                  | 0005 |      0.128 ms |         4 |      0.036 ms |    2059361.267615 s |    2059361.267652 s |
    (s)NET_RX:3               | 0002 |      0.125 ms |         4 |      0.035 ms |    2059365.423649 s |    2059365.423684 s |
   ---------------------------------------------------------------------------------------------------------------------------
    INFO: 0.003% skipped events (3 including 0 entry, 3 exit)

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/builtin-kwork.c | 97 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index 5741a8ac3e41..1eb416faf8ef 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -708,16 +708,109 @@ static struct kwork_class kwork_irq = {
 	.cluster_name   = irq_cluster_name,
 };
 
+static struct kwork_class kwork_softirq;
+static int process_softirq_entry_event(struct perf_tool *tool,
+				       struct evsel *evsel,
+				       struct perf_sample *sample,
+				       struct machine *machine)
+{
+	struct perf_kwork *kwork = container_of(tool, struct perf_kwork, tool);
+
+	if (kwork->tp_handler->entry_event)
+		return kwork->tp_handler->entry_event(kwork, &kwork_softirq,
+						      evsel, sample, machine);
+
+	return 0;
+}
+
+static int process_softirq_exit_event(struct perf_tool *tool,
+				      struct evsel *evsel,
+				      struct perf_sample *sample,
+				      struct machine *machine)
+{
+	struct perf_kwork *kwork = container_of(tool, struct perf_kwork, tool);
+
+	if (kwork->tp_handler->exit_event)
+		return kwork->tp_handler->exit_event(kwork, &kwork_softirq,
+						     evsel, sample, machine);
+
+	return 0;
+}
+
 const struct evsel_str_handler softirq_tp_handlers[] = {
 	{ "irq:softirq_raise", NULL, },
-	{ "irq:softirq_entry", NULL, },
-	{ "irq:softirq_exit",  NULL, },
+	{ "irq:softirq_entry", process_softirq_entry_event, },
+	{ "irq:softirq_exit",  process_softirq_exit_event, },
 };
 
+static int softirq_class_init(struct kwork_class *class,
+			      struct perf_session *session)
+{
+	if (perf_session__set_tracepoints_handlers(session,
+						   softirq_tp_handlers)) {
+		pr_debug("Failed to set softirq tracepoints handlers\n");
+		return -1;
+	}
+
+	class->cluster_root = RB_ROOT_CACHED;
+	return 0;
+}
+
+static char *evsel__softirq_name(struct evsel *evsel, u64 num)
+{
+	char *name = NULL;
+	bool found = false;
+	struct tep_print_flag_sym *sym = NULL;
+	struct tep_print_arg *args = evsel->tp_format->print_fmt.args;
+
+	if ((args == NULL) || (args->next == NULL))
+		return NULL;
+
+	/* skip softirq field: "REC->vec" */
+	for (sym = args->next->symbol.symbols; sym != NULL; sym = sym->next) {
+		if ((eval_flag(sym->value) == (unsigned long long)num) &&
+		    (strlen(sym->str) != 0)) {
+			found = true;
+			break;
+		}
+	}
+
+	if (!found)
+		return NULL;
+
+	name = strdup(sym->str);
+	if (name == NULL) {
+		pr_debug("Failed to copy symbol name\n");
+		return NULL;
+	}
+	return name;
+}
+
+static void softirq_cluster_init(struct kwork_class *class,
+				 struct kwork_cluster *cluster,
+				 struct evsel *evsel,
+				 struct perf_sample *sample)
+{
+	u64 num = evsel__intval(evsel, sample, "vec");
+
+	cluster->id = num;
+	cluster->class = class;
+	cluster->cpu = sample->cpu;
+	cluster->name = evsel__softirq_name(evsel, num);
+}
+
+static void softirq_cluster_name(struct kwork_cluster *cluster, char *buf, int len)
+{
+	snprintf(buf, len, "(s)%s:%" PRIu64 "", cluster->name, cluster->id);
+}
+
 static struct kwork_class kwork_softirq = {
 	.name           = "softirq",
 	.nr_tracepoints = 3,
 	.tp_handlers    = softirq_tp_handlers,
+	.class_init     = softirq_class_init,
+	.cluster_init   = softirq_cluster_init,
+	.cluster_name   = softirq_cluster_name,
 };
 
 const struct evsel_str_handler workqueue_tp_handlers[] = {
-- 
2.30.GIT

