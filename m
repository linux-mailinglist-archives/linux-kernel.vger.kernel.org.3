Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C81D474C64
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 21:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237550AbhLNUAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 15:00:17 -0500
Received: from relay027.a.hostedemail.com ([64.99.140.27]:19507 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230188AbhLNUAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 15:00:16 -0500
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id DEB4B21FB8;
        Tue, 14 Dec 2021 20:00:14 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id C5E342002A;
        Tue, 14 Dec 2021 20:00:10 +0000 (UTC)
Message-ID: <a4e810c6f4654e7e4fafdcc8d07ea482a28a6390.camel@perches.com>
Subject: Re: [PATCH] sched/fair: fix boolreturn.cocci warning
From:   Joe Perches <joe@perches.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     cgel.zte@gmail.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Date:   Tue, 14 Dec 2021 12:00:11 -0800
In-Reply-To: <20211214105216.1f313e72@gandalf.local.home>
References: <20211214113845.439392-1-deng.changcheng@zte.com.cn>
         <20211214091446.383ec08e@gandalf.local.home>
         <b1cb1fd9be34d2fcec2578e06facc4168de4f554.camel@perches.com>
         <20211214105216.1f313e72@gandalf.local.home>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: kex9qmf8uubut38uggcrdj6ms3m3yf97
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: C5E342002A
X-Spam-Status: No, score=-3.40
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/5jRDSE8rP2x641ajvSQhsIfsFBRRekX0=
X-HE-Tag: 1639512010-482706
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-12-14 at 10:52 -0500, Steven Rostedt wrote:
> On Tue, 14 Dec 2021 07:24:34 -0800
> Joe Perches <joe@perches.com> wrote:
> 
> > Perhaps it is more a change for consistency than a fix for correctness.
> > 
> > $ git grep -P 'return\s+(?:true|false)' kernel/sched/ | wc -l
> > 209
> 
> As with those other changes, it should be fixed when the function is
> updated. No need to add the churn now.

<shrug> that's the only bool 1/0 return in the subsystem.

Overall there are very few uses of this pattern in the kernel.

There are about 35000 uses of return true/false
and fewer than 50 uses of return 1/0

$ git grep  -P '\breturn\s+(?:true|false)\s*;' -- '*.[ch]' | wc -l
34828

$ cat bool.cocci
@@
typedef bool;
identifier fn;
@@

 bool fn(...)
 {
	<...
*	return \(1\|0\);
	...>
 }

@@
typedef bool;
identifier fn;
expression e;
@@

 bool fn(...)
 {
	<...
*	return e ? 1 : 0;
	...>
 }

$ spatch -sp-file bool.cocci . | grep -P '^(diff|\@|\-[^\-])'
diff -u -p ./arch/arm/mach-omap2/cm2xxx.c /tmp/nothing/arch/arm/mach-omap2/cm2xxx.c
@@ -58,7 +58,6 @@ static bool omap2xxx_cm_is_clkdm_in_hwsu
-	return (v == OMAP24XX_CLKSTCTRL_ENABLE_AUTO) ? 1 : 0;
diff -u -p ./arch/arm/mach-omap2/cm3xxx.c /tmp/nothing/arch/arm/mach-omap2/cm3xxx.c
@@ -47,7 +47,6 @@ static bool omap3xxx_cm_is_clkdm_in_hwsu
-	return (v == OMAP34XX_CLKSTCTRL_ENABLE_AUTO) ? 1 : 0;
diff -u -p ./arch/arm/mach-omap2/powerdomain.c /tmp/nothing/arch/arm/mach-omap2/powerdomain.c
@@ -968,7 +968,6 @@ int pwrdm_disable_hdwr_sar(struct powerd
-	return (pwrdm && pwrdm->flags & PWRDM_HAS_HDWR_SAR) ? 1 : 0;
diff -u -p ./arch/arm/mach-omap2/prm44xx.c /tmp/nothing/arch/arm/mach-omap2/prm44xx.c
@@ -403,7 +403,6 @@ static u32 omap44xx_prm_read_reset_sourc
-	return (omap4_prminst_read_inst_reg(part, inst, idx)) ? 1 : 0;
diff -u -p ./arch/arm/mm/nommu.c /tmp/nothing/arch/arm/mm/nommu.c
@@ -56,7 +56,6 @@ static inline bool security_extensions_e
-	return 0;
diff -u -p ./arch/x86/boot/compressed/kaslr.c /tmp/nothing/arch/x86/boot/compressed/kaslr.c
@@ -668,7 +668,6 @@ static bool process_mem_region(struct me
-	return 0;
diff -u -p ./arch/x86/events/intel/lbr.c /tmp/nothing/arch/x86/events/intel/lbr.c
@@ -914,7 +914,6 @@ static __always_inline int get_lbr_br_ty
-		return 0;
@@ -922,7 +921,6 @@ static __always_inline bool get_lbr_misp
-		return 0;
diff -u -p ./arch/x86/kvm/mmu/mmu.c /tmp/nothing/arch/x86/kvm/mmu/mmu.c
@@ -1482,7 +1482,6 @@ restart:
-		return 0;
@@ -1623,8 +1622,6 @@ static bool kvm_test_age_rmapp(struct kv
-			return 1;
-	return 0;
diff -u -p ./drivers/char/tpm/tpm_ftpm_tee.c /tmp/nothing/drivers/char/tpm/tpm_ftpm_tee.c
@@ -177,7 +177,6 @@ static u8 ftpm_tee_tpm_op_status(struct
-	return 0;
diff -u -p ./drivers/clk/at91/clk-pll.c /tmp/nothing/drivers/clk/at91/clk-pll.c
@@ -49,7 +49,6 @@ static inline bool clk_pll_ready(struct
-	return status & PLL_STATUS_MASK(id) ? 1 : 0;
diff -u -p ./drivers/irqchip/irq-csky-apb-intc.c /tmp/nothing/drivers/irqchip/irq-csky-apb-intc.c
@@ -136,11 +136,9 @@ static inline bool handle_irq_perbit(str
-		return 0;
-	return 1;
diff -u -p ./drivers/mtd/nand/core.c /tmp/nothing/drivers/mtd/nand/core.c
@@ -22,7 +22,6 @@
-		return 0;
diff -u -p ./drivers/net/ethernet/marvell/octeontx2/af/rvu.c /tmp/nothing/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -1240,9 +1240,7 @@ static bool is_blktype_attached(struct r
-		return pfvf->npalf ? 1 : 0;
-		return pfvf->nixlf ? 1 : 0;
diff -u -p ./drivers/net/wireless/ath/ath5k/dma.c /tmp/nothing/drivers/net/wireless/ath/ath5k/dma.c
@@ -505,7 +505,6 @@ done:
-	return ath5k_hw_reg_read(ah, AR5K_INTPEND) == 1 ? 1 : 0;
diff -u -p ./drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c /tmp/nothing/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
@@ -219,5 +219,4 @@ bool mt7921s_tx_status_data(struct mt76_
-	return 0;
diff -u -p ./drivers/pci/controller/pcie-xilinx.c /tmp/nothing/drivers/pci/controller/pcie-xilinx.c
@@ -122,8 +122,6 @@ static inline void pcie_write(struct xil
-	return (pcie_read(port, XILINX_PCIE_REG_PSCR) &
-		XILINX_PCIE_REG_PSCR_LNKUP) ? 1 : 0;
diff -u -p ./drivers/scsi/elx/libefc_sli/sli4.c /tmp/nothing/drivers/scsi/elx/libefc_sli/sli4.c
@@ -4036,7 +4036,6 @@ sli_fw_ready(struct sli4 *sli4)
-	return (val & SLI4_PORT_STATUS_RDY) ? 1 : 0;
diff -u -p ./fs/nfsd/nfs2acl.c /tmp/nothing/fs/nfsd/nfs2acl.c
@@ -249,34 +249,26 @@ nfsaclsvc_encode_getaclres(struct svc_rq
-		return 0;
-		return 1;
-		return 0;
-		return 0;
-			return 1;
-		return 0;
-		return 0;
-	return 1;
@@ -286,17 +278,13 @@ nfsaclsvc_encode_accessres(struct svc_rq
-		return 0;
-			return 0;
-			return 0;
-	return 1;
diff -u -p ./kernel/locking/rtmutex.c /tmp/nothing/kernel/locking/rtmutex.c
@@ -372,24 +372,19 @@ static __always_inline bool __waiter_les
-		return 1;
-		return 0;
-		return 0;
-			return 1;
-	return 0;
diff -u -p ./kernel/locking/rwbase_rt.c /tmp/nothing/kernel/locking/rwbase_rt.c
@@ -223,10 +223,8 @@ static inline bool __rwbase_write_tryloc
-		return 1;
-	return 0;
diff -u -p ./kernel/sched/fair.c /tmp/nothing/kernel/sched/fair.c
@@ -9777,9 +9777,7 @@ imbalanced_active_balance(struct lb_env
-		return 1;
-	return 0;


