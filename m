Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3104B3307
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 06:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiBLFDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 00:03:40 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiBLFDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 00:03:35 -0500
Received: from relay.hostedemail.com (relay.hostedemail.com [64.99.140.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121B6216
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 21:03:31 -0800 (PST)
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay10.hostedemail.com (Postfix) with ESMTP id B59E31965;
        Sat, 12 Feb 2022 05:01:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id B903024;
        Sat, 12 Feb 2022 05:01:23 +0000 (UTC)
Message-ID: <200fe5cb203ad5cc00c5c60b7ded2cd85c9b85ea.camel@perches.com>
Subject: Re: [PATCH v2] ACPI/IORT: Fix GCC 12 warning
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Victor Erminpour <victor.erminpour@oracle.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        trivial@kernel.org
In-Reply-To: <202202111623.A7881CC@keescook>
References: <1644518851-16847-1-git-send-email-victor.erminpour@oracle.com>
         <CAMj1kXEbGWs74M2CZSm6TWpD11mReFsk8z-UUqJt6b6vDCvAEQ@mail.gmail.com>
         <202202101415.43750CEE@keescook>
         <3740c93e-9fde-f89f-9752-26ffff3ea274@arm.com>
         <202202111623.A7881CC@keescook>
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
Date:   Fri, 11 Feb 2022 20:50:50 -0800
User-Agent: Evolution 3.40.4-1ubuntu2 
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 413wozmcznkzcybfhmyndqnq59394nsr
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: B903024
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/dkyNDhmaVSlCq1xV4VtNvOU1aeYRw6bs=
X-HE-Tag: 1644642083-485617
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-02-11 at 16:37 -0800, Kees Cook wrote:
[]
> Well, I'm for #1, though perhaps with a more narrow view: some semantics
> are just weird/surprising. ;) Until I first encountered this warning a
> few years ago when working on GCC_PLUGIN_STRUCTLEAK_BYREF_ALL, I didn't
> even know putting declarations there was valid C. ;)
> 
> Whack-a-mole is part of the work to make these kinds of treewide
> changes, but the hope is to find as much of it ahead of time as
> possible. And, no, I have no interest in security theater. (Not
> everything has equal levels of effectiveness, of course, but I don't
> think that's what you're saying.)
> 
> > In fairness I'd have no objection to that patch if it came with a convincing
> > justification, but that is so far very much lacking. My aim here is not to
> > be a change-averse Luddite, but to try to find a compromise where I can
> > actually have some confidence in such changes being made. Let's not start
> > pretending that 3 100ml bottles of shampoo are somehow "safer" than a 300ml
> > bottle of shampoo...
> 
> Sure. I think I am trying to take a pragmatic approach here, which is
> that gaining auto-var-init is a big deal (killing entire classes of
> vulnerabilities), but it comes with an annoying compiler bug (that we do
> get a warning about) for an uncommon code pattern that is easy to fix.
> So rather than delaying the defense until the sharp edge on the compiler
> gets fixed, I'd like to get the rest rolling while the edge is filed.

coccinelle would probably find most all of them.

$ cat switch_define.cocci
@@
expression e;
type t;
identifier i;
@@

	switch (e) {
*	t i;
	}
	
$ spatch --very-quiet -sp-file switch_define.cocci .
13831 files match
diff -u -p ./arch/arc/kernel/unwind.c /tmp/nothing/arch/arc/kernel/unwind.c
--- ./arch/arc/kernel/unwind.c
+++ /tmp/nothing/arch/arc/kernel/unwind.c
@@ -718,7 +718,6 @@ static int processCFI(const u8 *start, c
 	}
 	for (ptr.p8 = start; result && ptr.p8 < end;) {
 		switch (*ptr.p8 >> 6) {
-			uleb128_t value;
 
 		case 0:
 			opcode = *ptr.p8++;
diff -u -p ./arch/arm/kernel/module-plts.c /tmp/nothing/arch/arm/kernel/module-plts.c
--- ./arch/arm/kernel/module-plts.c
+++ /tmp/nothing/arch/arm/kernel/module-plts.c
@@ -124,7 +124,6 @@ static bool is_zero_addend_relocation(El
 	 * PC bias into account, i.e., -8 for ARM and -4 for Thumb2.
 	 */
 	switch (ELF32_R_TYPE(rel->r_info)) {
-		u16 upper, lower;
 
 	case R_ARM_THM_CALL:
 	case R_ARM_THM_JUMP24:
diff -u -p ./arch/mips/mti-malta/malta-init.c /tmp/nothing/arch/mips/mti-malta/malta-init.c
--- ./arch/mips/mti-malta/malta-init.c
+++ /tmp/nothing/arch/mips/mti-malta/malta-init.c
@@ -168,7 +168,6 @@ void __init prom_init(void)
 	}
 
 	switch (mips_revision_sconid) {
-		u32 start, map, mask, data;
 
 	case MIPS_REVISION_SCON_GT64120:
 		/*
diff -u -p ./arch/parisc/kernel/inventory.c /tmp/nothing/arch/parisc/kernel/inventory.c
--- ./arch/parisc/kernel/inventory.c
+++ /tmp/nothing/arch/parisc/kernel/inventory.c
@@ -235,7 +235,6 @@ pat_query_module(ulong pcell_loc, ulong
 #ifdef DEBUG_PAT
 	/* dump what we see so far... */
 	switch (PAT_GET_ENTITY(dev->mod_info)) {
-		pdc_pat_cell_mod_maddr_block_t io_pdc_cell;
 		unsigned long i;
 
 	case PAT_ENTITY_PROC:
diff -u -p ./arch/powerpc/xmon/xmon.c /tmp/nothing/arch/powerpc/xmon/xmon.c
--- ./arch/powerpc/xmon/xmon.c
+++ /tmp/nothing/arch/powerpc/xmon/xmon.c
@@ -1528,7 +1528,6 @@ bpt_cmds(void)
 	cmd = inchar();
 
 	switch (cmd) {
-	static const char badaddr[] = "Only kernel addresses are permitted for breakpoints\n";
 	int mode;
 	case 'd':	/* bd - hardware data breakpoint */
 		if (xmon_is_ro) {
diff -u -p ./arch/um/drivers/ubd_kern.c /tmp/nothing/arch/um/drivers/ubd_kern.c
--- ./arch/um/drivers/ubd_kern.c
+++ /tmp/nothing/arch/um/drivers/ubd_kern.c
@@ -1407,7 +1407,6 @@ static int ubd_ioctl(struct block_device
 	u16 ubd_id[ATA_ID_WORDS];
 
 	switch (cmd) {
-		struct cdrom_volctrl volume;
 	case HDIO_GET_IDENTITY:
 		memset(&ubd_id, 0, ATA_ID_WORDS * 2);
 		ubd_id[ATA_ID_CYLS]	= ubd_dev->size / (128 * 32 * 512);
diff -u -p ./arch/x86/kernel/cpu/cyrix.c /tmp/nothing/arch/x86/kernel/cpu/cyrix.c
--- ./arch/x86/kernel/cpu/cyrix.c
+++ /tmp/nothing/arch/x86/kernel/cpu/cyrix.c
@@ -224,7 +224,6 @@ static void init_cyrix(struct cpuinfo_x8
 	 */
 
 	switch (dir0_msn) {
-		unsigned char tmp;
 
 	case 0: /* Cx486SLC/DLC/SRx/DRx */
 		p = Cx486_name[dir0_lsn & 7];
diff -u -p ./arch/x86/pci/irq.c /tmp/nothing/arch/x86/pci/irq.c
--- ./arch/x86/pci/irq.c
+++ /tmp/nothing/arch/x86/pci/irq.c
@@ -959,7 +959,6 @@ static __init int intel_router_probe(str
 		return 0;
 
 	switch (device) {
-		u8 rid;
 	case PCI_DEVICE_ID_INTEL_82375:
 		r->name = "PCEB/ESC";
 		r->get = pirq_esc_get;
diff -u -p ./drivers/acpi/arm64/iort.c /tmp/nothing/drivers/acpi/arm64/iort.c
--- ./drivers/acpi/arm64/iort.c
+++ /tmp/nothing/drivers/acpi/arm64/iort.c
@@ -1667,7 +1667,6 @@ phys_addr_t __init acpi_iort_dma_get_max
 			break;
 
 		switch (node->type) {
-			struct acpi_iort_named_component *ncomp;
 			struct acpi_iort_root_complex *rc;
 			phys_addr_t local_limit;
 
diff -u -p ./drivers/infiniband/hw/irdma/hw.c /tmp/nothing/drivers/infiniband/hw/irdma/hw.c
--- ./drivers/infiniband/hw/irdma/hw.c
+++ /tmp/nothing/drivers/infiniband/hw/irdma/hw.c
@@ -267,7 +267,6 @@ static void irdma_process_aeq(struct ird
 		}
 
 		switch (info->ae_id) {
-			struct irdma_cm_node *cm_node;
 		case IRDMA_AE_LLP_CONNECTION_ESTABLISHED:
 			cm_node = iwqp->cm_node;
 			if (cm_node->accept_pend) {
diff -u -p ./drivers/infiniband/hw/irdma/utils.c /tmp/nothing/drivers/infiniband/hw/irdma/utils.c
--- ./drivers/infiniband/hw/irdma/utils.c
+++ /tmp/nothing/drivers/infiniband/hw/irdma/utils.c
@@ -1212,7 +1212,6 @@ enum irdma_status_code irdma_hw_modify_q
 			return status;
 
 		switch (m_info->next_iwarp_state) {
-			struct irdma_gen_ae_info ae_info;
 
 		case IRDMA_QP_STATE_RTS:
 		case IRDMA_QP_STATE_IDLE:
diff -u -p ./drivers/input/serio/hil_mlc.c /tmp/nothing/drivers/input/serio/hil_mlc.c
--- ./drivers/input/serio/hil_mlc.c
+++ /tmp/nothing/drivers/input/serio/hil_mlc.c
@@ -633,7 +633,6 @@ static int hilse_donode(hil_mlc *mlc)
 	node = hil_mlc_se + mlc->seidx;
 
 	switch (node->act) {
-		int rc;
 		hil_packet pack;
 
 	case HILSE_FUNC:
diff -u -p ./drivers/rtc/rtc-pcf8523.c /tmp/nothing/drivers/rtc/rtc-pcf8523.c
--- ./drivers/rtc/rtc-pcf8523.c
+++ /tmp/nothing/drivers/rtc/rtc-pcf8523.c
@@ -242,7 +242,6 @@ static int pcf8523_param_get(struct devi
 	int ret;
 
 	switch(param->param) {
-		u32 value;
 
 	case RTC_PARAM_BACKUP_SWITCH_MODE:
 		ret = regmap_read(pcf8523->regmap, PCF8523_REG_CONTROL3, &value);
@@ -281,7 +280,6 @@ static int pcf8523_param_set(struct devi
 	struct pcf8523 *pcf8523 = dev_get_drvdata(dev);
 
 	switch(param->param) {
-		u8 mode;
 	case RTC_PARAM_BACKUP_SWITCH_MODE:
 		switch (param->uvalue) {
 		case RTC_BSM_DISABLED:
diff -u -p ./drivers/rtc/rtc-rv3028.c /tmp/nothing/drivers/rtc/rtc-rv3028.c
--- ./drivers/rtc/rtc-rv3028.c
+++ /tmp/nothing/drivers/rtc/rtc-rv3028.c
@@ -523,7 +523,6 @@ static int rv3028_param_get(struct devic
 	int ret;
 
 	switch(param->param) {
-		u32 value;
 
 	case RTC_PARAM_BACKUP_SWITCH_MODE:
 		ret = regmap_read(rv3028->regmap, RV3028_BACKUP, &value);
@@ -556,7 +555,6 @@ static int rv3028_param_set(struct devic
 	struct rv3028_data *rv3028 = dev_get_drvdata(dev);
 
 	switch(param->param) {
-		u8 mode;
 	case RTC_PARAM_BACKUP_SWITCH_MODE:
 		switch (param->uvalue) {
 		case RTC_BSM_DISABLED:
diff -u -p ./drivers/rtc/rtc-rv3032.c /tmp/nothing/drivers/rtc/rtc-rv3032.c
--- ./drivers/rtc/rtc-rv3032.c
+++ /tmp/nothing/drivers/rtc/rtc-rv3032.c
@@ -401,7 +401,6 @@ static int rv3032_param_get(struct devic
 	int ret;
 
 	switch(param->param) {
-		u32 value;
 
 	case RTC_PARAM_BACKUP_SWITCH_MODE:
 		ret = regmap_read(rv3032->regmap, RV3032_PMU, &value);
@@ -435,7 +434,6 @@ static int rv3032_param_set(struct devic
 	struct rv3032_data *rv3032 = dev_get_drvdata(dev);
 
 	switch(param->param) {
-		u8 mode;
 	case RTC_PARAM_BACKUP_SWITCH_MODE:
 		if (rv3032->trickle_charger_set)
 			return -EINVAL;
diff -u -p ./drivers/s390/net/ctcm_fsms.c /tmp/nothing/drivers/s390/net/ctcm_fsms.c
--- ./drivers/s390/net/ctcm_fsms.c
+++ /tmp/nothing/drivers/s390/net/ctcm_fsms.c
@@ -1432,7 +1432,6 @@ static void ctcmpc_chx_rx(fsm_instance *
 
 again:
 	switch (fsm_getstate(grp->fsm)) {
-	int rc, dolock;
 	case MPCG_STATE_FLOWC:
 	case MPCG_STATE_READY:
 		if (ctcm_checkalloc_buffer(ch))
diff -u -p ./lib/test_stackinit.c /tmp/nothing/lib/test_stackinit.c
--- ./lib/test_stackinit.c
+++ /tmp/nothing/lib/test_stackinit.c
@@ -398,7 +398,6 @@ static int noinline __leaf_switch_none(i
 		 * This is intentionally unreachable. To silence the
 		 * warning, build with -Wno-switch-unreachable
 		 */
-		uint64_t var;
 
 	case 1:
 		target_start = &var;
diff -u -p ./net/mpls/af_mpls.c /tmp/nothing/net/mpls/af_mpls.c
--- ./net/mpls/af_mpls.c
+++ /tmp/nothing/net/mpls/af_mpls.c
@@ -1621,7 +1621,6 @@ static int mpls_dev_notify(struct notifi
 		return NOTIFY_OK;
 
 	switch (event) {
-		int err;
 
 	case NETDEV_DOWN:
 		err = mpls_ifdown(dev, event);
diff -u -p ./scripts/recordmcount.c /tmp/nothing/scripts/recordmcount.c
--- ./scripts/recordmcount.c
+++ /tmp/nothing/scripts/recordmcount.c
@@ -488,7 +488,6 @@ static int do_file(char const *const fna
 	w2 = w2nat;
 	w8 = w8nat;
 	switch (ehdr->e_ident[EI_DATA]) {
-		static unsigned int const endian = 1;
 	default:
 		fprintf(stderr, "unrecognized ELF data encoding %d: %s\n",
 			ehdr->e_ident[EI_DATA], fname);
diff -u -p ./tools/testing/selftests/powerpc/nx-gzip/gunz_test.c /tmp/nothing/tools/testing/selftests/powerpc/nx-gzip/gunz_test.c
--- ./tools/testing/selftests/powerpc/nx-gzip/gunz_test.c
+++ /tmp/nothing/tools/testing/selftests/powerpc/nx-gzip/gunz_test.c
@@ -805,7 +805,6 @@ ok_cc3:
 	 */
 
 	switch (sfbt) {
-		int dhtlen;
 
 	case 0x0: /* Deflate final EOB received */
 
diff -u -p ./tools/testing/selftests/proc/read.c /tmp/nothing/tools/testing/selftests/proc/read.c
--- ./tools/testing/selftests/proc/read.c
+++ /tmp/nothing/tools/testing/selftests/proc/read.c
@@ -91,7 +91,6 @@ static void f(DIR *d, unsigned int level
 		assert(!streq(de->d_name, ".."));
 
 		switch (de->d_type) {
-			DIR *dd;
 			int fd;
 
 		case DT_REG:
$ 

