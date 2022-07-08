Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CC456B3F1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237375AbiGHIAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiGHIAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:00:21 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C4A65D7E;
        Fri,  8 Jul 2022 01:00:20 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1o9iuM-00FrrZ-3T; Fri, 08 Jul 2022 18:00:15 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 08 Jul 2022 16:00:14 +0800
Date:   Fri, 8 Jul 2022 16:00:14 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Zhengchao Shao <shaozhengchao@huawei.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        yekai13@huawei.com, liulongfang@huawei.com, davem@davemloft.net,
        weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH v2] crypto: hisilicon/sec - don't sleep when in softirq
Message-ID: <YsfkDp4myfbKj0Kf@gondor.apana.org.au>
References: <20220630122622.55492-1-shaozhengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630122622.55492-1-shaozhengchao@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 08:26:22PM +0800, Zhengchao Shao wrote:
> When kunpeng920 encryption driver is used to deencrypt and decrypt
> packets during the softirq, it is not allowed to use mutex lock. The
> kernel will report the following error:
> 
> BUG: scheduling while atomic: swapper/57/0/0x00000300
> Call trace:
> dump_backtrace+0x0/0x1e4
> show_stack+0x20/0x2c
> dump_stack+0xd8/0x140
> __schedule_bug+0x68/0x80
> __schedule+0x728/0x840
> schedule+0x50/0xe0
> schedule_preempt_disabled+0x18/0x24
> __mutex_lock.constprop.0+0x594/0x5dc
> __mutex_lock_slowpath+0x1c/0x30
> mutex_lock+0x50/0x60
> sec_request_init+0x8c/0x1a0 [hisi_sec2]
> sec_process+0x28/0x1ac [hisi_sec2]
> sec_skcipher_crypto+0xf4/0x1d4 [hisi_sec2]
> sec_skcipher_encrypt+0x1c/0x30 [hisi_sec2]
> crypto_skcipher_encrypt+0x2c/0x40
> crypto_authenc_encrypt+0xc8/0xfc [authenc]
> crypto_aead_encrypt+0x2c/0x40
> echainiv_encrypt+0x144/0x1a0 [echainiv]
> crypto_aead_encrypt+0x2c/0x40
> esp_output_tail+0x348/0x5c0 [esp4]
> esp_output+0x120/0x19c [esp4]
> xfrm_output_one+0x25c/0x4d4
> xfrm_output_resume+0x6c/0x1fc
> xfrm_output+0xac/0x3c0
> xfrm4_output+0x64/0x130
> ip_build_and_send_pkt+0x158/0x20c
> tcp_v4_send_synack+0xdc/0x1f0
> tcp_conn_request+0x7d0/0x994
> tcp_v4_conn_request+0x58/0x6c
> tcp_v6_conn_request+0xf0/0x100
> tcp_rcv_state_process+0x1cc/0xd60
> tcp_v4_do_rcv+0x10c/0x250
> tcp_v4_rcv+0xfc4/0x10a4
> ip_protocol_deliver_rcu+0xf4/0x200
> ip_local_deliver_finish+0x58/0x70
> ip_local_deliver+0x68/0x120
> ip_sublist_rcv_finish+0x70/0x94
> ip_list_rcv_finish.constprop.0+0x17c/0x1d0
> ip_sublist_rcv+0x40/0xb0
> ip_list_rcv+0x140/0x1dc
> __netif_receive_skb_list_core+0x154/0x28c
> __netif_receive_skb_list+0x120/0x1a0
> netif_receive_skb_list_internal+0xe4/0x1f0
> napi_complete_done+0x70/0x1f0
> gro_cell_poll+0x9c/0xb0
> napi_poll+0xcc/0x264
> net_rx_action+0xd4/0x21c
> __do_softirq+0x130/0x358
> irq_exit+0x11c/0x13c
> __handle_domain_irq+0x88/0xf0
> gic_handle_irq+0x78/0x2c0
> el1_irq+0xb8/0x140
> arch_cpu_idle+0x18/0x40
> default_idle_call+0x5c/0x1c0
> cpuidle_idle_call+0x174/0x1b0
> do_idle+0xc8/0x160
> cpu_startup_entry+0x30/0x11c
> secondary_start_kernel+0x158/0x1e4
> softirq: huh, entered softirq 3 NET_RX 0000000093774ee4 with
> preempt_count 00000100, exited with fffffe00?
> 
> V1: use spin_lock will cause soft lockup
> 
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>  drivers/crypto/hisilicon/sec2/sec.h        |  2 +-
>  drivers/crypto/hisilicon/sec2/sec_crypto.c | 20 ++++++++++----------
>  2 files changed, 11 insertions(+), 11 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
