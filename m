Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCB65856C2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 00:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238942AbiG2WHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 18:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiG2WHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 18:07:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146BC8BABC
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 15:07:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5084062026
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 22:07:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B12FC433C1;
        Fri, 29 Jul 2022 22:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659132426;
        bh=ys++DNuloPsw4XmjdMLSWe5LSi5lRxVcMVhmJvIr1GM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z8ONq0AGa0TPrUgKfjStVwv3fd9S1VqwIjLJyrNZhdt5mBp33/iMgMpOSogVqxAZR
         nXbGDUQByhkzXxVHWcrxqaRnhgQ1B6bp4amnJ3v7pYpx2tBH5RgOmaMxSmQDYaoYdN
         CFq+GlfyeezJInILZoM2mBoFbP2TED9p6XXNIXJjRRnEn0dlFvBZsi9MfpjSQbgmRr
         +Lp+0AuyS6OhF8nnF7Ptjh+uq1dwCLrA7NvTDWh616719NgSjQHE04dJDHSqCTYZ7o
         8FzMKmhvBeALeISRxOwYeFAO/Fb3HurcvBIc6q9RbJvuldVq9P/vIbXHWnEj8XCT/2
         AOjA1jFdsNEAw==
Date:   Fri, 29 Jul 2022 15:07:04 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jorgen Hansen <jhansen@vmware.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        gregkh@linuxfoundation.org, pv-drivers@vmware.com,
        Vishnu Dasa <vdasa@vmware.com>
Subject: Re: [PATCH 8/8] VMCI: dma dg: add support for DMA datagrams receive
Message-ID: <YuRaCCN9MqE5OjXH@dev-arch.thelio-3990X>
References: <20220202144910.10349-1-jhansen@vmware.com>
 <20220202144910.10349-9-jhansen@vmware.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dXZvnDVhCxPQHnjO"
Content-Disposition: inline
In-Reply-To: <20220202144910.10349-9-jhansen@vmware.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dXZvnDVhCxPQHnjO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jorgen,

On Wed, Feb 02, 2022 at 06:49:10AM -0800, Jorgen Hansen wrote:
> Use the DMA based receive operation instead of the ioread8_rep
> based datagram receive when DMA datagrams are supported.
> 
> In the receive operation, configure the header to point to the
> page aligned VMCI_MAX_DG_SIZE part of the receive buffer
> using s/g configuration for the header. This ensures that the
> existing dispatch routine can be used with little modification.
> Initiate the receive by writing the lower 32 bit of the buffer
> to the VMCI_DATA_IN_LOW_ADDR register, and wait for the busy
> flag to be changed by the device using a wait queue.
> 
> The existing dispatch routine for received  datagrams is reused
> for the DMA datagrams with a few modifications:
> - the receive buffer is always the maximum size for DMA datagrams
>   (IO ports would try with a shorter buffer first to reduce
>   overhead of the ioread8_rep operation).
> - for DMA datagrams, datagrams are provided contiguous in the
>   buffer as opposed to IO port datagrams, where they can start
>   on any page boundary
> 
> Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
> Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
> ---
>  drivers/misc/vmw_vmci/vmci_guest.c | 103 ++++++++++++++++++++++-------
>  1 file changed, 79 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
> index ca73a1913404..2bcfa292772d 100644
> --- a/drivers/misc/vmw_vmci/vmci_guest.c
> +++ b/drivers/misc/vmw_vmci/vmci_guest.c
> @@ -58,6 +58,7 @@ struct vmci_guest_device {
>  
>  	struct tasklet_struct datagram_tasklet;
>  	struct tasklet_struct bm_tasklet;
> +	struct wait_queue_head inout_wq;
>  
>  	void *data_buffer;
>  	dma_addr_t data_buffer_base;
> @@ -115,6 +116,36 @@ void vmci_write_reg(struct vmci_guest_device *dev, u32 val, u32 reg)
>  		iowrite32(val, dev->iobase + reg);
>  }
>  
> +static void vmci_read_data(struct vmci_guest_device *vmci_dev,
> +			   void *dest, size_t size)
> +{
> +	if (vmci_dev->mmio_base == NULL)
> +		ioread8_rep(vmci_dev->iobase + VMCI_DATA_IN_ADDR,
> +			    dest, size);
> +	else {
> +		/*
> +		 * For DMA datagrams, the data_buffer will contain the header on the
> +		 * first page, followed by the incoming datagram(s) on the following
> +		 * pages. The header uses an S/G element immediately following the
> +		 * header on the first page to point to the data area.
> +		 */
> +		struct vmci_data_in_out_header *buffer_header = vmci_dev->data_buffer;
> +		struct vmci_sg_elem *sg_array = (struct vmci_sg_elem *)(buffer_header + 1);
> +		size_t buffer_offset = dest - vmci_dev->data_buffer;
> +
> +		buffer_header->opcode = 1;
> +		buffer_header->size = 1;
> +		buffer_header->busy = 0;
> +		sg_array[0].addr = vmci_dev->data_buffer_base + buffer_offset;
> +		sg_array[0].size = size;
> +
> +		vmci_write_reg(vmci_dev, lower_32_bits(vmci_dev->data_buffer_base),
> +			       VMCI_DATA_IN_LOW_ADDR);
> +
> +		wait_event(vmci_dev->inout_wq, buffer_header->busy == 1);

Apologies if this has been reported somewhere (or if this change is not
the root cause, I did not bother bisecting, I just inferred based on the
call chain) or if there is a patch for this issue somewhere that I did
not notice.

When CONFIG_DEBUG_ATOMIC_SLEEP is enabled, this call to wait_event()
causes a BUG in dmesg, which I see when booting Fedora Rawhide in VMware
Fusion on my MacBook Air. As far as I can tell, the kernel is vanilla.

[   20.264639] BUG: sleeping function called from invalid context at drivers/misc/vmw_vmci/vmci_guest.c:145
[   20.264643] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 762, name: vmtoolsd
[   20.264645] preempt_count: 101, expected: 0
[   20.264646] RCU nest depth: 0, expected: 0
[   20.264647] 1 lock held by vmtoolsd/762:
[   20.264648]  #0: ffff0000874ae440 (sk_lock-AF_VSOCK){+.+.}-{0:0}, at: vsock_connect+0x60/0x330 [vsock]
[   20.264658] Preemption disabled at:
[   20.264659] [<ffff80000151d7d8>] vmci_send_datagram+0x44/0xa0 [vmw_vmci]
[   20.264665] CPU: 0 PID: 762 Comm: vmtoolsd Not tainted 5.19.0-0.rc8.20220727git39c3c396f813.60.fc37.aarch64 #1
[   20.264667] Hardware name: VMware, Inc. VBSA/VBSA, BIOS VEFI 12/31/2020
[   20.264668] Call trace:
[   20.264669]  dump_backtrace+0xc4/0x130
[   20.264672]  show_stack+0x24/0x80
[   20.264673]  dump_stack_lvl+0x88/0xb4
[   20.264676]  dump_stack+0x18/0x34
[   20.264677]  __might_resched+0x1a0/0x280
[   20.264679]  __might_sleep+0x58/0x90
[   20.264681]  vmci_read_data+0x74/0x120 [vmw_vmci]
[   20.264683]  vmci_dispatch_dgs+0x64/0x204 [vmw_vmci]
[   20.264686]  tasklet_action_common.constprop.0+0x13c/0x150
[   20.264688]  tasklet_action+0x40/0x50
[   20.264689]  __do_softirq+0x23c/0x6b4
[   20.264690]  __irq_exit_rcu+0x104/0x214
[   20.264691]  irq_exit_rcu+0x1c/0x50
[   20.264693]  el1_interrupt+0x38/0x6c
[   20.264695]  el1h_64_irq_handler+0x18/0x24
[   20.264696]  el1h_64_irq+0x68/0x6c
[   20.264697]  preempt_count_sub+0xa4/0xe0
[   20.264698]  _raw_spin_unlock_irqrestore+0x64/0xb0
[   20.264701]  vmci_send_datagram+0x7c/0xa0 [vmw_vmci]
[   20.264703]  vmci_datagram_dispatch+0x84/0x100 [vmw_vmci]
[   20.264706]  vmci_datagram_send+0x2c/0x40 [vmw_vmci]
[   20.264709]  vmci_transport_send_control_pkt+0xb8/0x120 [vmw_vsock_vmci_transport]
[   20.264711]  vmci_transport_connect+0x40/0x7c [vmw_vsock_vmci_transport]
[   20.264713]  vsock_connect+0x278/0x330 [vsock]
[   20.264715]  __sys_connect_file+0x8c/0xc0
[   20.264718]  __sys_connect+0x84/0xb4
[   20.264720]  __arm64_sys_connect+0x2c/0x3c
[   20.264721]  invoke_syscall+0x78/0x100
[   20.264723]  el0_svc_common.constprop.0+0x68/0x124
[   20.264724]  do_el0_svc+0x38/0x4c
[   20.264725]  el0_svc+0x60/0x180
[   20.264726]  el0t_64_sync_handler+0x11c/0x150
[   20.264728]  el0t_64_sync+0x190/0x194

Attached is the entire dmesg in case it is useful, as I see several
messages with different "preemption disabled at" values.

If there is any additional information I can provide or patches I can
test, please let me know.

Cheers,
Nathan

> +	}
> +}
> +
>  int vmci_write_data(struct vmci_guest_device *dev, struct vmci_datagram *dg)
>  {
>  	int result;
> @@ -260,15 +291,17 @@ static int vmci_check_host_caps(struct pci_dev *pdev)
>  }
>  
>  /*
> - * Reads datagrams from the data in port and dispatches them. We
> - * always start reading datagrams into only the first page of the
> - * datagram buffer. If the datagrams don't fit into one page, we
> - * use the maximum datagram buffer size for the remainder of the
> - * invocation. This is a simple heuristic for not penalizing
> - * small datagrams.
> + * Reads datagrams from the device and dispatches them. For IO port
> + * based access to the device, we always start reading datagrams into
> + * only the first page of the datagram buffer. If the datagrams don't
> + * fit into one page, we use the maximum datagram buffer size for the
> + * remainder of the invocation. This is a simple heuristic for not
> + * penalizing small datagrams. For DMA-based datagrams, we always
> + * use the maximum datagram buffer size, since there is no performance
> + * penalty for doing so.
>   *
>   * This function assumes that it has exclusive access to the data
> - * in port for the duration of the call.
> + * in register(s) for the duration of the call.
>   */
>  static void vmci_dispatch_dgs(unsigned long data)
>  {
> @@ -276,23 +309,41 @@ static void vmci_dispatch_dgs(unsigned long data)
>  	u8 *dg_in_buffer = vmci_dev->data_buffer;
>  	struct vmci_datagram *dg;
>  	size_t dg_in_buffer_size = VMCI_MAX_DG_SIZE;
> -	size_t current_dg_in_buffer_size = PAGE_SIZE;
> +	size_t current_dg_in_buffer_size;
>  	size_t remaining_bytes;
> +	bool is_io_port = vmci_dev->mmio_base == NULL;
>  
>  	BUILD_BUG_ON(VMCI_MAX_DG_SIZE < PAGE_SIZE);
>  
> -	ioread8_rep(vmci_dev->iobase + VMCI_DATA_IN_ADDR,
> -		    vmci_dev->data_buffer, current_dg_in_buffer_size);
> +	if (!is_io_port) {
> +		/* For mmio, the first page is used for the header. */
> +		dg_in_buffer += PAGE_SIZE;
> +
> +		/*
> +		 * For DMA-based datagram operations, there is no performance
> +		 * penalty for reading the maximum buffer size.
> +		 */
> +		current_dg_in_buffer_size = VMCI_MAX_DG_SIZE;
> +	} else {
> +		current_dg_in_buffer_size = PAGE_SIZE;
> +	}
> +	vmci_read_data(vmci_dev, dg_in_buffer, current_dg_in_buffer_size);
>  	dg = (struct vmci_datagram *)dg_in_buffer;
>  	remaining_bytes = current_dg_in_buffer_size;
>  
> +	/*
> +	 * Read through the buffer until an invalid datagram header is
> +	 * encountered. The exit condition for datagrams read through
> +	 * VMCI_DATA_IN_ADDR is a bit more complicated, since a datagram
> +	 * can start on any page boundary in the buffer.
> +	 */
>  	while (dg->dst.resource != VMCI_INVALID_ID ||
> -	       remaining_bytes > PAGE_SIZE) {
> +	       (is_io_port && remaining_bytes > PAGE_SIZE)) {
>  		unsigned dg_in_size;
>  
>  		/*
> -		 * When the input buffer spans multiple pages, a datagram can
> -		 * start on any page boundary in the buffer.
> +		 * If using VMCI_DATA_IN_ADDR, skip to the next page
> +		 * as a datagram can start on any page boundary.
>  		 */
>  		if (dg->dst.resource == VMCI_INVALID_ID) {
>  			dg = (struct vmci_datagram *)roundup(
> @@ -342,11 +393,10 @@ static void vmci_dispatch_dgs(unsigned long data)
>  					current_dg_in_buffer_size =
>  					    dg_in_buffer_size;
>  
> -				ioread8_rep(vmci_dev->iobase +
> -						VMCI_DATA_IN_ADDR,
> -					vmci_dev->data_buffer +
> +				vmci_read_data(vmci_dev,
> +					       dg_in_buffer +
>  						remaining_bytes,
> -					current_dg_in_buffer_size -
> +					       current_dg_in_buffer_size -
>  						remaining_bytes);
>  			}
>  
> @@ -384,10 +434,8 @@ static void vmci_dispatch_dgs(unsigned long data)
>  				current_dg_in_buffer_size = dg_in_buffer_size;
>  
>  			for (;;) {
> -				ioread8_rep(vmci_dev->iobase +
> -						VMCI_DATA_IN_ADDR,
> -					vmci_dev->data_buffer,
> -					current_dg_in_buffer_size);
> +				vmci_read_data(vmci_dev, dg_in_buffer,
> +					       current_dg_in_buffer_size);
>  				if (bytes_to_skip <= current_dg_in_buffer_size)
>  					break;
>  
> @@ -404,8 +452,7 @@ static void vmci_dispatch_dgs(unsigned long data)
>  		if (remaining_bytes < VMCI_DG_HEADERSIZE) {
>  			/* Get the next batch of datagrams. */
>  
> -			ioread8_rep(vmci_dev->iobase + VMCI_DATA_IN_ADDR,
> -				    vmci_dev->data_buffer,
> +			vmci_read_data(vmci_dev, dg_in_buffer,
>  				    current_dg_in_buffer_size);
>  			dg = (struct vmci_datagram *)dg_in_buffer;
>  			remaining_bytes = current_dg_in_buffer_size;
> @@ -463,8 +510,11 @@ static irqreturn_t vmci_interrupt(int irq, void *_dev)
>  			icr &= ~VMCI_ICR_NOTIFICATION;
>  		}
>  
> -		if (icr & VMCI_ICR_DMA_DATAGRAM)
> +
> +		if (icr & VMCI_ICR_DMA_DATAGRAM) {
> +			wake_up_all(&dev->inout_wq);
>  			icr &= ~VMCI_ICR_DMA_DATAGRAM;
> +		}
>  
>  		if (icr != 0)
>  			dev_warn(dev->dev,
> @@ -497,6 +547,10 @@ static irqreturn_t vmci_interrupt_bm(int irq, void *_dev)
>   */
>  static irqreturn_t vmci_interrupt_dma_datagram(int irq, void *_dev)
>  {
> +	struct vmci_guest_device *dev = _dev;
> +
> +	wake_up_all(&dev->inout_wq);
> +
>  	return IRQ_HANDLED;
>  }
>  
> @@ -586,6 +640,7 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
>  		     vmci_dispatch_dgs, (unsigned long)vmci_dev);
>  	tasklet_init(&vmci_dev->bm_tasklet,
>  		     vmci_process_bitmap, (unsigned long)vmci_dev);
> +	init_waitqueue_head(&vmci_dev->inout_wq);
>  
>  	if (mmio_base != NULL) {
>  		vmci_dev->tx_buffer = dma_alloc_coherent(&pdev->dev, VMCI_DMA_DG_BUFFER_SIZE,
> -- 
> 2.25.1
> 
> 

--dXZvnDVhCxPQHnjO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="vmci_read_data.log"

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x610f0000]
[    0.000000] Linux version 5.19.0-0.rc8.20220727git39c3c396f813.60.fc37.aarch64 (mockbuild@buildvm-a64-03.iad2.fedoraproject.org) (gcc (GCC) 12.1.1 20220628 (Red Hat 12.1.1-3), GNU ld version 2.38-18.fc37) #1 SMP PREEMPT_DYNAMIC Wed Jul 27 18:34:00 UTC 2022
[    0.000000] Machine model: linux,dummy-virt
[    0.000000] efi: EFI v2.70 by EDK II
[    0.000000] efi: SMBIOS 3.0=0x17f580000 ACPI=0xffff0000 ACPI 2.0=0xffff0014 MEMATTR=0x17ed6ea98 MOKvar=0x17f560000 MEMRESERVE=0x17c101098 
[    0.000000] NUMA: No NUMA configuration found
[    0.000000] NUMA: Faking a node at [mem 0x0000000080000000-0x000000017fffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x17f7a8080-0x17f7befff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000080000000-0x00000000ffffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000017fffffff]
[    0.000000]   Device   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080000000-0x00000000ffd28fff]
[    0.000000]   node   0: [mem 0x00000000ffd29000-0x00000000ffefffff]
[    0.000000]   node   0: [mem 0x00000000fff00000-0x000000017bf3ffff]
[    0.000000]   node   0: [mem 0x000000017bf40000-0x000000017c02ffff]
[    0.000000]   node   0: [mem 0x000000017c030000-0x000000017c05ffff]
[    0.000000]   node   0: [mem 0x000000017c060000-0x000000017c0fffff]
[    0.000000]   node   0: [mem 0x000000017c100000-0x000000017f3dffff]
[    0.000000]   node   0: [mem 0x000000017f3e0000-0x000000017f46ffff]
[    0.000000]   node   0: [mem 0x000000017f470000-0x000000017f55ffff]
[    0.000000]   node   0: [mem 0x000000017f560000-0x000000017f59ffff]
[    0.000000]   node   0: [mem 0x000000017f5a0000-0x000000017fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x000000017fffffff]
[    0.000000] cma: Reserved 64 MiB at 0x00000000fbc00000
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv0.2 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: Trusted OS migration not required
[    0.000000] percpu: Embedded 481 pages/cpu s1929512 r8192 d32472 u1970176
[    0.000000] pcpu-alloc: s1929512 r8192 d32472 u1970176 alloc=481*4096
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Detected PIPT I-cache on CPU0
[    0.000000] CPU features: detected: Address authentication (IMP DEF algorithm)
[    0.000000] CPU features: detected: GIC system register CPU interface
[    0.000000] CPU features: detected: Spectre-v4
[    0.000000] alternatives: patching kernel code
[    0.000000] Fallback order for Node 0: 0 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 1032192
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=(hd0,gpt2)/vmlinuz-5.19.0-0.rc8.20220727git39c3c396f813.60.fc37.aarch64 root=UUID=16e73dad-6fdb-44b2-9c9a-14842fa5b046 ro rootflags=subvol=root rhgb quiet
[    0.000000] Unknown kernel command line parameters "rhgb BOOT_IMAGE=(hd0,gpt2)/vmlinuz-5.19.0-0.rc8.20220727git39c3c396f813.60.fc37.aarch64", will be passed to user space.
[    0.000000] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] software IO TLB: mapped [mem 0x00000000f7c00000-0x00000000fbc00000] (64MB)
[    0.000000] Memory: 3865728K/4194304K available (18304K kernel code, 4792K rwdata, 13936K rodata, 9536K init, 30671K bss, 263040K reserved, 65536K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] kmemleak: Kernel memory leak detector disabled
[    0.000000] ftrace: allocating 57831 entries in 226 pages
[    0.000000] ftrace: allocated 226 pages with 4 groups
[    0.000000] trace event string verifier disabled
[    0.000000] Dynamic Preempt: voluntary
[    0.000000] Running RCU self tests
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu: 	RCU lockdep checking is enabled.
[    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=4096 to nr_cpu_ids=1.
[    0.000000] rcu: 	RCU callback double-/use-after-free debug is enabled.
[    0.000000] 	Trampoline variant of Tasks RCU enabled.
[    0.000000] 	Rude variant of Tasks RCU enabled.
[    0.000000] 	Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: 960 SPIs implemented
[    0.000000] GICv3: 0 Extended SPIs implemented
[    0.000000] GICv3: MBI range [64:990]
[    0.000000] GICv3: Using MBI frame 0x000000002c010000
[    0.000000] Root IRQ handler: gic_handle_irq
[    0.000000] GICv3: GICv3 features: 16 PPIs
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x000000002c100000
[    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.000000] arch_timer: cp15 timer(s) running at 24.00MHz (virt).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
[    0.000000] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps every 4398046511097ns
[    0.000037] Console: colour dummy device 80x25
[    0.000046] printk: console [tty0] enabled
[    0.000056] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.000057] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000058] ... MAX_LOCK_DEPTH:          48
[    0.000059] ... MAX_LOCKDEP_KEYS:        8192
[    0.000060] ... CLASSHASH_SIZE:          4096
[    0.000060] ... MAX_LOCKDEP_ENTRIES:     65536
[    0.000061] ... MAX_LOCKDEP_CHAINS:      131072
[    0.000062] ... CHAINHASH_SIZE:          65536
[    0.000063]  memory used by lock dependency info: 11641 kB
[    0.000063]  memory used for stack traces: 4224 kB
[    0.000064]  per task-struct memory footprint: 2688 bytes
[    0.000093] Calibrating delay loop (skipped), value calculated using timer frequency.. 48.00 BogoMIPS (lpj=240000)
[    0.000095] pid_max: default: 32768 minimum: 301
[    0.000149] LSM: Security Framework initializing
[    0.000160] Yama: becoming mindful.
[    0.000166] SELinux:  Initializing.
[    0.000206] LSM support for eBPF active
[    0.000208] landlock: Up and running.
[    0.000252] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.000255] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.000913] cblist_init_generic: Setting adjustable number of callback queues.
[    0.000916] cblist_init_generic: Setting shift to 0 and lim to 1.
[    0.000959] cblist_init_generic: Setting shift to 0 and lim to 1.
[    0.000991] cblist_init_generic: Setting shift to 0 and lim to 1.
[    0.001022] Running RCU-tasks wait API self tests
[    0.122027] rcu: Hierarchical SRCU implementation.
[    0.122031] rcu: 	Max phase no-delay instances is 1000.
[    0.123761] Remapping and enabling EFI services.
[    0.124152] smp: Bringing up secondary CPUs ...
[    0.124158] smp: Brought up 1 node, 1 CPU
[    0.124161] SMP: Total of 1 processors activated.
[    0.124176] CPU features: detected: ARMv8.4 Translation Table Level
[    0.124179] CPU features: detected: Data cache clean to the PoU not required for I/D coherence
[    0.124181] CPU features: detected: Common not Private translations
[    0.124184] CPU features: detected: CRC32 instructions
[    0.124186] CPU features: detected: Data cache clean to Point of Deep Persistence
[    0.124188] CPU features: detected: Data cache clean to Point of Persistence
[    0.124190] CPU features: detected: E0PD
[    0.124193] CPU features: detected: Generic authentication (IMP DEF algorithm)
[    0.124195] CPU features: detected: RCpc load-acquire (LDAPR)
[    0.124197] CPU features: detected: LSE atomic instructions
[    0.124200] CPU features: detected: Privileged Access Never
[    0.124202] CPU features: detected: RAS Extension Support
[    0.124204] CPU features: detected: Speculation barrier (SB)
[    0.124207] CPU features: detected: TLB range maintenance instructions
[    0.124211] CPU features: detected: Speculative Store Bypassing Safe (SSBS)
[    0.141850] Callback from call_rcu_tasks_trace() invoked.
[    0.143800] CPU: All CPU(s) started at EL1
[    0.144980] allocated 16777216 bytes of page_ext
[    0.145377] devtmpfs: initialized
[    0.148666] Registered cp15_barrier emulation handler
[    0.148668] setend instruction emulation is not supported on this system
[    0.148673] KASLR disabled due to lack of seed
[    0.151891] DMA-API: preallocated 65536 debug entries
[    0.151893] DMA-API: debugging enabled by kernel config
[    0.151895] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.151900] futex hash table entries: 256 (order: 3, 32768 bytes, linear)
[    0.158372] pinctrl core: initialized pinctrl subsystem

[    0.158934] *************************************************************
[    0.158935] **     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    **
[    0.158936] **                                                         **
[    0.158937] **  IOMMU DebugFS SUPPORT HAS BEEN ENABLED IN THIS KERNEL  **
[    0.158939] **                                                         **
[    0.158940] ** This means that this kernel is built to expose internal **
[    0.158941] ** IOMMU data structures, which may compromise security on **
[    0.158942] ** your system.                                            **
[    0.158943] **                                                         **
[    0.158944] ** If you see this message and you are not debugging the   **
[    0.158945] ** kernel, report this immediately to your vendor!         **
[    0.158946] **                                                         **
[    0.158948] **     NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE    **
[    0.158949] *************************************************************
[    0.159031] SMBIOS 3.0.0 present.
[    0.159034] DMI: VMware, Inc. VBSA/VBSA, BIOS VEFI 12/31/2020
[    0.159331] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.160124] DMA: preallocated 512 KiB GFP_KERNEL pool for atomic allocations
[    0.160186] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.160373] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.160409] audit: initializing netlink subsys (disabled)
[    0.160953] thermal_sys: Registered thermal governor 'fair_share'
[    0.160955] thermal_sys: Registered thermal governor 'step_wise'
[    0.160957] thermal_sys: Registered thermal governor 'user_space'
[    0.160968] cpuidle: using governor menu
[    0.161001] hw-breakpoint: found 2 breakpoint and 2 watchpoint registers.
[    0.161023] ASID allocator initialised with 256 entries
[    0.161026] HugeTLB: can optimize 4095 vmemmap pages for hugepages-1048576kB
[    0.161028] HugeTLB: can optimize 127 vmemmap pages for hugepages-32768kB
[    0.161030] HugeTLB: can optimize 7 vmemmap pages for hugepages-2048kB
[    0.161032] HugeTLB: can optimize 0 vmemmap pages for hugepages-64kB
[    0.161298] Serial: AMBA PL011 UART driver
[    0.169949] audit: type=2000 audit(0.140:1): state=initialized audit_enabled=0 res=1
[    0.175597] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.175599] HugeTLB registered 32.0 MiB page size, pre-allocated 0 pages
[    0.175600] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.175601] HugeTLB registered 64.0 KiB page size, pre-allocated 0 pages
[    0.176294] cryptd: max_cpu_qlen set to 1000
[    0.176683] raid6: skipped pq benchmark and selected neonx8
[    0.176684] raid6: using neon recovery algorithm
[    0.176818] ACPI: Interpreter disabled.
[    0.177000] iommu: Default domain type: Translated 
[    0.177001] iommu: DMA domain TLB invalidation policy: lazy mode 
[    0.177315] SCSI subsystem initialized
[    0.177378] libata version 3.00 loaded.
[    0.177488] usbcore: registered new interface driver usbfs
[    0.177510] usbcore: registered new interface driver hub
[    0.177527] usbcore: registered new device driver usb
[    0.177591] pps_core: LinuxPPS API ver. 1 registered
[    0.177592] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.177601] PTP clock support registered
[    0.177673] EDAC MC: Ver: 3.0.0
[    0.177981] Registered efivars operations
[    0.178518] NetLabel: Initializing
[    0.178520] NetLabel:  domain hash size = 128
[    0.178521] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.178544] NetLabel:  unlabeled traffic allowed by default
[    0.178549] mctp: management component transport protocol core
[    0.178550] NET: Registered PF_MCTP protocol family
[    0.178678] vgaarb: loaded
[    0.178941] clocksource: Switched to clocksource arch_sys_counter
[    0.179284] VFS: Disk quotas dquot_6.6.0
[    0.179309] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.179483] pnp: PnP ACPI: disabled
[    0.191008] NET: Registered PF_INET protocol family
[    0.191066] IP idents hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.191788] tcp_listen_portaddr_hash hash table entries: 2048 (order: 5, 163840 bytes, linear)
[    0.191804] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.191813] TCP established hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.192044] TCP bind hash table entries: 32768 (order: 9, 2621440 bytes, linear)
[    0.192249] TCP: Hash tables configured (established 32768 bind 32768)
[    0.192326] MPTCP token hash table entries: 4096 (order: 6, 393216 bytes, linear)
[    0.192384] UDP hash table entries: 2048 (order: 6, 393216 bytes, linear)
[    0.192431] UDP-Lite hash table entries: 2048 (order: 6, 393216 bytes, linear)
[    0.192543] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.192552] NET: Registered PF_XDP protocol family
[    0.192555] PCI: CLS 0 bytes, default 64
[    0.192707] kvm [1]: HYP mode not available
[    0.193256] Trying to unpack rootfs image as initramfs...
[    0.239052] Callback from call_rcu_tasks_rude() invoked.
[    0.302602] Initialise system trusted keyrings
[    0.302648] Key type blacklist registered
[    0.310234] workingset: timestamp_bits=37 max_order=20 bucket_order=0
[    0.316460] zbud: loaded
[    0.329881] integrity: Platform Keyring initialized
[    0.329889] integrity: Machine keyring initialized
[    0.338125] NET: Registered PF_ALG protocol family
[    0.338134] xor: measuring software checksum speed
[    0.338558]    8regs           : 23370 MB/sec
[    0.338772]    32regs          : 48247 MB/sec
[    0.339220]    arm64_neon      : 23759 MB/sec
[    0.339221] xor: using function: 32regs (48247 MB/sec)
[    0.349204] Key type asymmetric registered
[    0.349209] Asymmetric key parser 'x509' registered
[    0.589339] Freeing initrd memory: 31724K
[    0.593596] modprobe (41) used greatest stack depth: 12784 bytes left
[    0.597604] alg: self-tests for CTR-KDF (hmac(sha256)) passed
[    0.597633] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 244)
[    0.597715] io scheduler mq-deadline registered
[    0.597717] io scheduler kyber registered
[    0.597830] io scheduler bfq registered
[    0.599045] Callback from call_rcu_tasks() invoked.
[    0.599307] atomic64_test: passed
[    0.599343] cryptomgr_test (49) used greatest stack depth: 12608 bytes left
[    0.600719] pci-host-generic 40000000.pcie: host bridge /pcie@0x40000000 ranges:
[    0.600731] pci-host-generic 40000000.pcie:      MEM 0x0030000000..0x003ffeffff -> 0x0030000000
[    0.600739] pci-host-generic 40000000.pcie:       IO 0x003fff0000..0x003fffffff -> 0x0000000000
[    0.600747] pci-host-generic 40000000.pcie:      MEM 0x0050000000..0x007fffffff -> 0x0050000000
[    0.600761] PCI: OF: PROBE_ONLY enabled
[    0.601998] pci-host-generic 40000000.pcie: ECAM at [mem 0x40000000-0x4fffffff] for [bus 00-ff]
[    0.602078] pci-host-generic 40000000.pcie: PCI host bridge to bus 0000:00
[    0.602080] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.602082] pci_bus 0000:00: root bus resource [mem 0x30000000-0x3ffeffff]
[    0.602083] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.602085] pci_bus 0000:00: root bus resource [mem 0x50000000-0x7fffffff pref]
[    0.602116] pci 0000:00:00.0: [15ad:1976] type 00 class 0x060000
[    0.602283] pci 0000:00:00.7: [15ad:0740] type 00 class 0x088000
[    0.602298] pci 0000:00:00.7: reg 0x10: [io  0xd000-0xd03f]
[    0.602309] pci 0000:00:00.7: reg 0x14: [mem 0x3de00000-0x3de3ffff 64bit]
[    0.602479] pci 0000:00:0f.0: [15ad:0406] type 00 class 0x030000
[    0.602667] pci 0000:00:0f.0: reg 0x10: [mem 0x3d000000-0x3d3fffff 64bit]
[    0.602786] pci 0000:00:0f.0: reg 0x18: [mem 0x70000000-0x77ffffff 64bit pref]
[    0.603228] pci 0000:00:0f.0: vgaarb: setting as boot VGA device
[    0.603230] pci 0000:00:0f.0: vgaarb: bridge control possible
[    0.603231] pci 0000:00:0f.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.603253] pci 0000:00:11.0: [15ad:0790] type 01 class 0x060401
[    0.603425] pci 0000:00:15.0: [15ad:07a0] type 01 class 0x060400
[    0.603520] pci 0000:00:15.0: PME# supported from D0 D3hot D3cold
[    0.603672] pci 0000:00:15.1: [15ad:07a0] type 01 class 0x060400
[    0.603766] pci 0000:00:15.1: PME# supported from D0 D3hot D3cold
[    0.603908] pci 0000:00:15.2: [15ad:07a0] type 01 class 0x060400
[    0.604001] pci 0000:00:15.2: PME# supported from D0 D3hot D3cold
[    0.604132] pci 0000:00:15.3: [15ad:07a0] type 01 class 0x060400
[    0.604225] pci 0000:00:15.3: PME# supported from D0 D3hot D3cold
[    0.604377] pci 0000:00:15.4: [15ad:07a0] type 01 class 0x060400
[    0.604470] pci 0000:00:15.4: PME# supported from D0 D3hot D3cold
[    0.604611] pci 0000:00:15.5: [15ad:07a0] type 01 class 0x060400
[    0.604704] pci 0000:00:15.5: PME# supported from D0 D3hot D3cold
[    0.604867] pci 0000:00:15.6: [15ad:07a0] type 01 class 0x060400
[    0.604961] pci 0000:00:15.6: PME# supported from D0 D3hot D3cold
[    0.605096] pci 0000:00:15.7: [15ad:07a0] type 01 class 0x060400
[    0.605190] pci 0000:00:15.7: PME# supported from D0 D3hot D3cold
[    0.605333] pci 0000:00:16.0: [15ad:07a0] type 01 class 0x060400
[    0.605427] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.605553] pci 0000:00:16.1: [15ad:07a0] type 01 class 0x060400
[    0.605647] pci 0000:00:16.1: PME# supported from D0 D3hot D3cold
[    0.605785] pci 0000:00:16.2: [15ad:07a0] type 01 class 0x060400
[    0.605879] pci 0000:00:16.2: PME# supported from D0 D3hot D3cold
[    0.606014] pci 0000:00:16.3: [15ad:07a0] type 01 class 0x060400
[    0.606108] pci 0000:00:16.3: PME# supported from D0 D3hot D3cold
[    0.606263] pci 0000:00:16.4: [15ad:07a0] type 01 class 0x060400
[    0.606357] pci 0000:00:16.4: PME# supported from D0 D3hot D3cold
[    0.606487] pci 0000:00:16.5: [15ad:07a0] type 01 class 0x060400
[    0.606580] pci 0000:00:16.5: PME# supported from D0 D3hot D3cold
[    0.606717] pci 0000:00:16.6: [15ad:07a0] type 01 class 0x060400
[    0.606810] pci 0000:00:16.6: PME# supported from D0 D3hot D3cold
[    0.606940] pci 0000:00:16.7: [15ad:07a0] type 01 class 0x060400
[    0.607033] pci 0000:00:16.7: PME# supported from D0 D3hot D3cold
[    0.607167] pci 0000:00:17.0: [15ad:07a0] type 01 class 0x060400
[    0.607261] pci 0000:00:17.0: PME# supported from D0 D3hot D3cold
[    0.607391] pci 0000:00:17.1: [15ad:07a0] type 01 class 0x060400
[    0.607484] pci 0000:00:17.1: PME# supported from D0 D3hot D3cold
[    0.607620] pci 0000:00:17.2: [15ad:07a0] type 01 class 0x060400
[    0.607714] pci 0000:00:17.2: PME# supported from D0 D3hot D3cold
[    0.607843] pci 0000:00:17.3: [15ad:07a0] type 01 class 0x060400
[    0.607936] pci 0000:00:17.3: PME# supported from D0 D3hot D3cold
[    0.608076] pci 0000:00:17.4: [15ad:07a0] type 01 class 0x060400
[    0.608169] pci 0000:00:17.4: PME# supported from D0 D3hot D3cold
[    0.608309] pci 0000:00:17.5: [15ad:07a0] type 01 class 0x060400
[    0.608410] pci 0000:00:17.5: PME# supported from D0 D3hot D3cold
[    0.608551] pci 0000:00:17.6: [15ad:07a0] type 01 class 0x060400
[    0.608645] pci 0000:00:17.6: PME# supported from D0 D3hot D3cold
[    0.608800] pci 0000:00:17.7: [15ad:07a0] type 01 class 0x060400
[    0.608894] pci 0000:00:17.7: PME# supported from D0 D3hot D3cold
[    0.609359] pci 0000:00:18.0: [15ad:07a0] type 01 class 0x060400
[    0.609453] pci 0000:00:18.0: PME# supported from D0 D3hot D3cold
[    0.609593] pci 0000:00:18.1: [15ad:07a0] type 01 class 0x060400
[    0.609687] pci 0000:00:18.1: PME# supported from D0 D3hot D3cold
[    0.609820] pci 0000:00:18.2: [15ad:07a0] type 01 class 0x060400
[    0.609913] pci 0000:00:18.2: PME# supported from D0 D3hot D3cold
[    0.610052] pci 0000:00:18.3: [15ad:07a0] type 01 class 0x060400
[    0.610146] pci 0000:00:18.3: PME# supported from D0 D3hot D3cold
[    0.610285] pci 0000:00:18.4: [15ad:07a0] type 01 class 0x060400
[    0.610379] pci 0000:00:18.4: PME# supported from D0 D3hot D3cold
[    0.610529] pci 0000:00:18.5: [15ad:07a0] type 01 class 0x060400
[    0.610623] pci 0000:00:18.5: PME# supported from D0 D3hot D3cold
[    0.610751] pci 0000:00:18.6: [15ad:07a0] type 01 class 0x060400
[    0.610845] pci 0000:00:18.6: PME# supported from D0 D3hot D3cold
[    0.610984] pci 0000:00:18.7: [15ad:07a0] type 01 class 0x060400
[    0.611078] pci 0000:00:18.7: PME# supported from D0 D3hot D3cold
[    0.611221] pci_bus 0000:01: extended config space not accessible
[    0.611267] pci 0000:01:00.0: [15ad:0774] type 00 class 0x0c0300
[    0.611406] pci 0000:01:00.0: reg 0x20: [io  0xc000-0xc01f]
[    0.611583] pci 0000:01:01.0: [15ad:1977] type 00 class 0x040300
[    0.611601] pci 0000:01:01.0: reg 0x10: [mem 0x3d400000-0x3d403fff 64bit]
[    0.611665] pci 0000:01:01.0: PME# supported from D0 D3hot D3cold
[    0.611782] pci 0000:01:02.0: [15ad:0770] type 00 class 0x0c0320
[    0.611812] pci 0000:01:02.0: reg 0x10: [mem 0x3d408000-0x3d40bfff]
[    0.612029] pci 0000:01:03.0: [15ad:07e0] type 00 class 0x010601
[    0.612151] pci 0000:01:03.0: reg 0x24: [mem 0x3d404000-0x3d407fff]
[    0.612211] pci 0000:01:03.0: PME# supported from D3hot
[    0.612457] pci 0000:02:00.0: [8086:10d3] type 00 class 0x020000
[    0.612492] pci 0000:02:00.0: reg 0x10: [mem 0x3fe00000-0x3fe1ffff]
[    0.612531] pci 0000:02:00.0: reg 0x18: [io  0xf000-0xf01f]
[    0.612551] pci 0000:02:00.0: reg 0x1c: [mem 0x3fe20000-0x3fe23fff]
[    0.612657] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    0.613475] pci 0000:0a:00.0: [15ad:0779] type 00 class 0x0c0330
[    0.613493] pci 0000:0a:00.0: reg 0x10: [mem 0x3f600000-0x3f67ffff 64bit]
[    0.613573] pci 0000:0a:00.0: PME# supported from D0 D3hot D3cold
[    0.613698] pci 0000:0a:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.614382] pci 0000:12:00.0: [15ad:07f0] type 00 class 0x010802
[    0.614416] pci 0000:12:00.0: reg 0x10: [mem 0x3ee00000-0x3ee03fff 64bit]
[    0.614435] pci 0000:12:00.0: reg 0x18: [io  0xe000-0xe007]
[    0.614559] pci 0000:12:00.0: PME# supported from D0 D3hot D3cold
[    0.614694] pci 0000:12:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.616145] pci 0000:00:11.0: PCI bridge to [bus 01] (subtractive decode)
[    0.616153] pci 0000:00:11.0:   bridge window [io  0xc000-0xcfff]
[    0.616156] pci 0000:00:11.0:   bridge window [mem 0x3d400000-0x3ddfffff]
[    0.616164] pci 0000:00:11.0:   bridge window [mem 0x78000000-0x784fffff 64bit pref]
[    0.616166] pci 0000:00:11.0:   bridge window [mem 0x30000000-0x3ffeffff] (subtractive decode)
[    0.616168] pci 0000:00:11.0:   bridge window [io  0x0000-0xffff] (subtractive decode)
[    0.616169] pci 0000:00:11.0:   bridge window [mem 0x50000000-0x7fffffff pref] (subtractive decode)
[    0.616172] pci 0000:00:15.0: PCI bridge to [bus 02]
[    0.616175] pci 0000:00:15.0:   bridge window [io  0xf000-0xffff]
[    0.616178] pci 0000:00:15.0:   bridge window [mem 0x3fe00000-0x3fefffff]
[    0.616184] pci 0000:00:15.1: PCI bridge to [bus 03]
[    0.616190] pci 0000:00:15.1:   bridge window [mem 0x3fd00000-0x3fdfffff]
[    0.616195] pci 0000:00:15.1:   bridge window [mem 0x7a100000-0x7a1fffff 64bit pref]
[    0.616197] pci 0000:00:15.2: PCI bridge to [bus 04]
[    0.616202] pci 0000:00:15.2:   bridge window [mem 0x3fc00000-0x3fcfffff]
[    0.616207] pci 0000:00:15.2:   bridge window [mem 0x7a000000-0x7a0fffff 64bit pref]
[    0.616209] pci 0000:00:15.3: PCI bridge to [bus 05]
[    0.616214] pci 0000:00:15.3:   bridge window [mem 0x3fb00000-0x3fbfffff]
[    0.616219] pci 0000:00:15.3:   bridge window [mem 0x79f00000-0x79ffffff 64bit pref]
[    0.616221] pci 0000:00:15.4: PCI bridge to [bus 06]
[    0.616226] pci 0000:00:15.4:   bridge window [mem 0x3fa00000-0x3fafffff]
[    0.616231] pci 0000:00:15.4:   bridge window [mem 0x79e00000-0x79efffff 64bit pref]
[    0.616233] pci 0000:00:15.5: PCI bridge to [bus 07]
[    0.616238] pci 0000:00:15.5:   bridge window [mem 0x3f900000-0x3f9fffff]
[    0.616244] pci 0000:00:15.5:   bridge window [mem 0x79d00000-0x79dfffff 64bit pref]
[    0.616245] pci 0000:00:15.6: PCI bridge to [bus 08]
[    0.616250] pci 0000:00:15.6:   bridge window [mem 0x3f800000-0x3f8fffff]
[    0.616256] pci 0000:00:15.6:   bridge window [mem 0x79c00000-0x79cfffff 64bit pref]
[    0.616257] pci 0000:00:15.7: PCI bridge to [bus 09]
[    0.616263] pci 0000:00:15.7:   bridge window [mem 0x3f700000-0x3f7fffff]
[    0.616268] pci 0000:00:15.7:   bridge window [mem 0x79b00000-0x79bfffff 64bit pref]
[    0.616270] pci 0000:00:16.0: PCI bridge to [bus 0a]
[    0.616275] pci 0000:00:16.0:   bridge window [mem 0x3f600000-0x3f6fffff]
[    0.616281] pci 0000:00:16.1: PCI bridge to [bus 0b]
[    0.616286] pci 0000:00:16.1:   bridge window [mem 0x3f500000-0x3f5fffff]
[    0.616291] pci 0000:00:16.1:   bridge window [mem 0x79a00000-0x79afffff 64bit pref]
[    0.616293] pci 0000:00:16.2: PCI bridge to [bus 0c]
[    0.616298] pci 0000:00:16.2:   bridge window [mem 0x3f400000-0x3f4fffff]
[    0.616303] pci 0000:00:16.2:   bridge window [mem 0x79900000-0x799fffff 64bit pref]
[    0.616305] pci 0000:00:16.3: PCI bridge to [bus 0d]
[    0.616310] pci 0000:00:16.3:   bridge window [mem 0x3f300000-0x3f3fffff]
[    0.616316] pci 0000:00:16.3:   bridge window [mem 0x79800000-0x798fffff 64bit pref]
[    0.616317] pci 0000:00:16.4: PCI bridge to [bus 0e]
[    0.616322] pci 0000:00:16.4:   bridge window [mem 0x3f200000-0x3f2fffff]
[    0.616328] pci 0000:00:16.4:   bridge window [mem 0x79700000-0x797fffff 64bit pref]
[    0.616329] pci 0000:00:16.5: PCI bridge to [bus 0f]
[    0.616335] pci 0000:00:16.5:   bridge window [mem 0x3f100000-0x3f1fffff]
[    0.616340] pci 0000:00:16.5:   bridge window [mem 0x79600000-0x796fffff 64bit pref]
[    0.616341] pci 0000:00:16.6: PCI bridge to [bus 10]
[    0.616347] pci 0000:00:16.6:   bridge window [mem 0x3f000000-0x3f0fffff]
[    0.616352] pci 0000:00:16.6:   bridge window [mem 0x79500000-0x795fffff 64bit pref]
[    0.616354] pci 0000:00:16.7: PCI bridge to [bus 11]
[    0.616359] pci 0000:00:16.7:   bridge window [mem 0x3ef00000-0x3effffff]
[    0.616364] pci 0000:00:16.7:   bridge window [mem 0x79400000-0x794fffff 64bit pref]
[    0.616366] pci 0000:00:17.0: PCI bridge to [bus 12]
[    0.616369] pci 0000:00:17.0:   bridge window [io  0xe000-0xefff]
[    0.616372] pci 0000:00:17.0:   bridge window [mem 0x3ee00000-0x3eefffff]
[    0.616378] pci 0000:00:17.1: PCI bridge to [bus 13]
[    0.616383] pci 0000:00:17.1:   bridge window [mem 0x3ed00000-0x3edfffff]
[    0.616388] pci 0000:00:17.1:   bridge window [mem 0x79300000-0x793fffff 64bit pref]
[    0.616390] pci 0000:00:17.2: PCI bridge to [bus 14]
[    0.616395] pci 0000:00:17.2:   bridge window [mem 0x3ec00000-0x3ecfffff]
[    0.616401] pci 0000:00:17.2:   bridge window [mem 0x79200000-0x792fffff 64bit pref]
[    0.616402] pci 0000:00:17.3: PCI bridge to [bus 15]
[    0.616408] pci 0000:00:17.3:   bridge window [mem 0x3eb00000-0x3ebfffff]
[    0.616413] pci 0000:00:17.3:   bridge window [mem 0x79100000-0x791fffff 64bit pref]
[    0.616414] pci 0000:00:17.4: PCI bridge to [bus 16]
[    0.616420] pci 0000:00:17.4:   bridge window [mem 0x3ea00000-0x3eafffff]
[    0.616425] pci 0000:00:17.4:   bridge window [mem 0x79000000-0x790fffff 64bit pref]
[    0.616427] pci 0000:00:17.5: PCI bridge to [bus 17]
[    0.616432] pci 0000:00:17.5:   bridge window [mem 0x3e900000-0x3e9fffff]
[    0.616437] pci 0000:00:17.5:   bridge window [mem 0x78f00000-0x78ffffff 64bit pref]
[    0.616439] pci 0000:00:17.6: PCI bridge to [bus 18]
[    0.616444] pci 0000:00:17.6:   bridge window [mem 0x3e800000-0x3e8fffff]
[    0.616449] pci 0000:00:17.6:   bridge window [mem 0x78e00000-0x78efffff 64bit pref]
[    0.616451] pci 0000:00:17.7: PCI bridge to [bus 19]
[    0.616456] pci 0000:00:17.7:   bridge window [mem 0x3e700000-0x3e7fffff]
[    0.616461] pci 0000:00:17.7:   bridge window [mem 0x78d00000-0x78dfffff 64bit pref]
[    0.616463] pci 0000:00:18.0: PCI bridge to [bus 1a]
[    0.616469] pci 0000:00:18.0:   bridge window [mem 0x3e600000-0x3e6fffff]
[    0.616474] pci 0000:00:18.0:   bridge window [mem 0x78c00000-0x78cfffff 64bit pref]
[    0.616476] pci 0000:00:18.1: PCI bridge to [bus 1b]
[    0.616481] pci 0000:00:18.1:   bridge window [mem 0x3e500000-0x3e5fffff]
[    0.616486] pci 0000:00:18.1:   bridge window [mem 0x78b00000-0x78bfffff 64bit pref]
[    0.616488] pci 0000:00:18.2: PCI bridge to [bus 1c]
[    0.616493] pci 0000:00:18.2:   bridge window [mem 0x3e400000-0x3e4fffff]
[    0.616499] pci 0000:00:18.2:   bridge window [mem 0x78a00000-0x78afffff 64bit pref]
[    0.616500] pci 0000:00:18.3: PCI bridge to [bus 1d]
[    0.616505] pci 0000:00:18.3:   bridge window [mem 0x3e300000-0x3e3fffff]
[    0.616511] pci 0000:00:18.3:   bridge window [mem 0x78900000-0x789fffff 64bit pref]
[    0.616512] pci 0000:00:18.4: PCI bridge to [bus 1e]
[    0.616518] pci 0000:00:18.4:   bridge window [mem 0x3e200000-0x3e2fffff]
[    0.616523] pci 0000:00:18.4:   bridge window [mem 0x78800000-0x788fffff 64bit pref]
[    0.616525] pci 0000:00:18.5: PCI bridge to [bus 1f]
[    0.616530] pci 0000:00:18.5:   bridge window [mem 0x3e100000-0x3e1fffff]
[    0.616535] pci 0000:00:18.5:   bridge window [mem 0x78700000-0x787fffff 64bit pref]
[    0.616537] pci 0000:00:18.6: PCI bridge to [bus 20]
[    0.616542] pci 0000:00:18.6:   bridge window [mem 0x3e000000-0x3e0fffff]
[    0.616547] pci 0000:00:18.6:   bridge window [mem 0x78600000-0x786fffff 64bit pref]
[    0.616549] pci 0000:00:18.7: PCI bridge to [bus 21]
[    0.616554] pci 0000:00:18.7:   bridge window [mem 0x3df00000-0x3dffffff]
[    0.616560] pci 0000:00:18.7:   bridge window [mem 0x78500000-0x785fffff 64bit pref]
[    0.616857] pcieport 0000:00:15.0: PME: Signaling with IRQ 13
[    0.616942] pcieport 0000:00:15.0: pciehp: Slot #160 AttnBtn+ PwrCtrl+ MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.617272] pcieport 0000:00:15.1: PME: Signaling with IRQ 14
[    0.617329] pcieport 0000:00:15.1: pciehp: Slot #161 AttnBtn+ PwrCtrl+ MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.617622] pcieport 0000:00:15.2: PME: Signaling with IRQ 15
[    0.617681] pcieport 0000:00:15.2: pciehp: Slot #162 AttnBtn+ PwrCtrl+ MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.617967] pcieport 0000:00:15.3: PME: Signaling with IRQ 16
[    0.618035] pcieport 0000:00:15.3: pciehp: Slot #163 AttnBtn+ PwrCtrl+ MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.618322] pcieport 0000:00:15.4: PME: Signaling with IRQ 17
[    0.618394] pcieport 0000:00:15.4: pciehp: Slot #164 AttnBtn+ PwrCtrl+ MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.618664] pcieport 0000:00:15.5: PME: Signaling with IRQ 18
[    0.618732] pcieport 0000:00:15.5: pciehp: Slot #165 AttnBtn+ PwrCtrl+ MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.619060] pcieport 0000:00:15.6: PME: Signaling with IRQ 19
[    0.619122] pcieport 0000:00:15.6: pciehp: Slot #166 AttnBtn+ PwrCtrl+ MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.619403] pcieport 0000:00:15.7: PME: Signaling with IRQ 20
[    0.619463] pcieport 0000:00:15.7: pciehp: Slot #167 AttnBtn+ PwrCtrl+ MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.619753] pcieport 0000:00:16.0: PME: Signaling with IRQ 21
[    0.619810] pcieport 0000:00:16.0: pciehp: Slot #192 AttnBtn+ PwrCtrl+ MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.620092] pcieport 0000:00:16.1: PME: Signaling with IRQ 22
[    0.620150] pcieport 0000:00:16.1: pciehp: Slot #193 AttnBtn+ PwrCtrl+ MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.620456] pcieport 0000:00:16.2: PME: Signaling with IRQ 23
[    0.620524] pcieport 0000:00:16.2: pciehp: Slot #194 AttnBtn+ PwrCtrl+ MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.620820] pcieport 0000:00:16.3: PME: Signaling with IRQ 24
[    0.620887] pcieport 0000:00:16.3: pciehp: Slot #195 AttnBtn+ PwrCtrl+ MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.621164] pcieport 0000:00:16.4: PME: Signaling with IRQ 25
[    0.621228] pcieport 0000:00:16.4: pciehp: Slot #196 AttnBtn+ PwrCtrl+ MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.621500] pcieport 0000:00:16.5: PME: Signaling with IRQ 26
[    0.621575] pcieport 0000:00:16.5: pciehp: Slot #197 AttnBtn+ PwrCtrl+ MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.621894] pcieport 0000:00:16.6: PME: Signaling with IRQ 27
[    0.621983] pcieport 0000:00:16.6: pciehp: Slot #198 AttnBtn+ PwrCtrl+ MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.622298] pcieport 0000:00:16.7: PME: Signaling with IRQ 28
[    0.622365] pcieport 0000:00:16.7: pciehp: Slot #199 AttnBtn+ PwrCtrl+ MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.622671] pcieport 0000:00:17.0: PME: Signaling with IRQ 29
[    0.622730] pcieport 0000:00:17.0: pciehp: Slot #224 AttnBtn+ PwrCtrl+ MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.623016] pcieport 0000:00:17.1: PME: Signaling with IRQ 30
[    0.623075] pcieport 0000:00:17.1: pciehp: Slot #225 AttnBtn+ PwrCtrl+ MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.623368] pcieport 0000:00:17.2: PME: Signaling with IRQ 31
[    0.623427] pcieport 0000:00:17.2: pciehp: Slot #226 AttnBtn+ PwrCtrl+ MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.623737] pcieport 0000:00:17.3: PME: Signaling with IRQ 32
[    0.623802] pcieport 0000:00:17.3: pciehp: Slot #227 AttnBtn+ PwrCtrl+ MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.624096] pcieport 0000:00:17.4: PME: Signaling with IRQ 33
[    0.624159] pcieport 0000:00:17.4: pciehp: Slot #228 AttnBtn+ PwrCtrl+ MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.624459] pcieport 0000:00:17.5: PME: Signaling with IRQ 34
[    0.624520] pcieport 0000:00:17.5: pciehp: Slot #229 AttnBtn+ PwrCtrl+ MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.624850] pcieport 0000:00:17.6: PME: Signaling with IRQ 35
[    0.624933] pcieport 0000:00:17.6: pciehp: Slot #230 AttnBtn+ PwrCtrl+ MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.625238] pcieport 0000:00:17.7: PME: Signaling with IRQ 36
[    0.625303] pcieport 0000:00:17.7: pciehp: Slot #231 AttnBtn+ PwrCtrl+ MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.625628] pcieport 0000:00:18.0: PME: Signaling with IRQ 37
[    0.625687] pcieport 0000:00:18.0: pciehp: Slot #256 AttnBtn+ PwrCtrl+ MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.625979] pcieport 0000:00:18.1: PME: Signaling with IRQ 38
[    0.626045] pcieport 0000:00:18.1: pciehp: Slot #257 AttnBtn+ PwrCtrl+ MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.626340] pcieport 0000:00:18.2: PME: Signaling with IRQ 39
[    0.626402] pcieport 0000:00:18.2: pciehp: Slot #258 AttnBtn+ PwrCtrl+ MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.626701] pcieport 0000:00:18.3: PME: Signaling with IRQ 40
[    0.626776] pcieport 0000:00:18.3: pciehp: Slot #259 AttnBtn+ PwrCtrl+ MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.627057] pcieport 0000:00:18.4: PME: Signaling with IRQ 41
[    0.627119] pcieport 0000:00:18.4: pciehp: Slot #260 AttnBtn+ PwrCtrl+ MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.627405] pcieport 0000:00:18.5: PME: Signaling with IRQ 42
[    0.627466] pcieport 0000:00:18.5: pciehp: Slot #261 AttnBtn+ PwrCtrl+ MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.627760] pcieport 0000:00:18.6: PME: Signaling with IRQ 43
[    0.627820] pcieport 0000:00:18.6: pciehp: Slot #262 AttnBtn+ PwrCtrl+ MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.628115] pcieport 0000:00:18.7: PME: Signaling with IRQ 44
[    0.628177] pcieport 0000:00:18.7: pciehp: Slot #263 AttnBtn+ PwrCtrl+ MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.628412] pci 0000:0a:00.0: enabling device (0000 -> 0002)
[    0.630373] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.635503] 3fff03f8.uart: ttyS0 at MMIO 0x3fff03f8 (irq = 45, base_baud = 230400) is a 8250
[    0.635884] 3fff02f8.uart: ttyS1 at MMIO 0x3fff02f8 (irq = 46, base_baud = 230400) is a 8250
[    0.636137] msm_serial: driver initialized
[    0.636584] cacheinfo: Unable to detect cache hierarchy for CPU 0
[    0.637152] ahci 0000:01:03.0: version 3.0
[    0.637529] ahci 0000:01:03.0: AHCI 0001.0300 32 slots 30 ports 6 Gbps 0x3fffffff impl SATA mode
[    0.637532] ahci 0000:01:03.0: flags: 64bit ncq clo only 
[    0.646922] scsi host0: ahci
[    0.647231] scsi host1: ahci
[    0.647474] scsi host2: ahci
[    0.647706] scsi host3: ahci
[    0.647939] scsi host4: ahci
[    0.648171] scsi host5: ahci
[    0.648395] scsi host6: ahci
[    0.648623] scsi host7: ahci
[    0.648857] scsi host8: ahci
[    0.649106] scsi host9: ahci
[    0.649344] scsi host10: ahci
[    0.649570] scsi host11: ahci
[    0.649815] scsi host12: ahci
[    0.650043] scsi host13: ahci
[    0.650266] scsi host14: ahci
[    0.650494] scsi host15: ahci
[    0.650721] scsi host16: ahci
[    0.650953] scsi host17: ahci
[    0.651194] scsi host18: ahci
[    0.651422] scsi host19: ahci
[    0.651648] scsi host20: ahci
[    0.651894] scsi host21: ahci
[    0.652118] scsi host22: ahci
[    0.652341] scsi host23: ahci
[    0.652577] scsi host24: ahci
[    0.652816] scsi host25: ahci
[    0.653049] scsi host26: ahci
[    0.653304] scsi host27: ahci
[    0.653531] scsi host28: ahci
[    0.653760] scsi host29: ahci
[    0.653885] ata1: SATA max UDMA/133 abar m16384@0x3d404000 port 0x3d404100 irq 48
[    0.653887] ata2: SATA max UDMA/133 abar m16384@0x3d404000 port 0x3d404180 irq 48
[    0.653888] ata3: SATA max UDMA/133 abar m16384@0x3d404000 port 0x3d404200 irq 48
[    0.653889] ata4: SATA max UDMA/133 abar m16384@0x3d404000 port 0x3d404280 irq 48
[    0.653890] ata5: SATA max UDMA/133 abar m16384@0x3d404000 port 0x3d404300 irq 48
[    0.653891] ata6: SATA max UDMA/133 abar m16384@0x3d404000 port 0x3d404380 irq 48
[    0.653892] ata7: SATA max UDMA/133 abar m16384@0x3d404000 port 0x3d404400 irq 48
[    0.653893] ata8: SATA max UDMA/133 abar m16384@0x3d404000 port 0x3d404480 irq 48
[    0.653894] ata9: SATA max UDMA/133 abar m16384@0x3d404000 port 0x3d404500 irq 48
[    0.653895] ata10: SATA max UDMA/133 abar m16384@0x3d404000 port 0x3d404580 irq 48
[    0.653896] ata11: SATA max UDMA/133 abar m16384@0x3d404000 port 0x3d404600 irq 48
[    0.653898] ata12: SATA max UDMA/133 abar m16384@0x3d404000 port 0x3d404680 irq 48
[    0.653899] ata13: SATA max UDMA/133 abar m16384@0x3d404000 port 0x3d404700 irq 48
[    0.653900] ata14: SATA max UDMA/133 abar m16384@0x3d404000 port 0x3d404780 irq 48
[    0.653901] ata15: SATA max UDMA/133 abar m16384@0x3d404000 port 0x3d404800 irq 48
[    0.653902] ata16: SATA max UDMA/133 abar m16384@0x3d404000 port 0x3d404880 irq 48
[    0.653903] ata17: SATA max UDMA/133 abar m16384@0x3d404000 port 0x3d404900 irq 48
[    0.653904] ata18: SATA max UDMA/133 abar m16384@0x3d404000 port 0x3d404980 irq 48
[    0.653905] ata19: SATA max UDMA/133 abar m16384@0x3d404000 port 0x3d404a00 irq 48
[    0.653906] ata20: SATA max UDMA/133 abar m16384@0x3d404000 port 0x3d404a80 irq 48
[    0.653907] ata21: SATA max UDMA/133 abar m16384@0x3d404000 port 0x3d404b00 irq 48
[    0.653908] ata22: SATA max UDMA/133 abar m16384@0x3d404000 port 0x3d404b80 irq 48
[    0.653909] ata23: SATA max UDMA/133 abar m16384@0x3d404000 port 0x3d404c00 irq 48
[    0.653910] ata24: SATA max UDMA/133 abar m16384@0x3d404000 port 0x3d404c80 irq 48
[    0.653911] ata25: SATA max UDMA/133 abar m16384@0x3d404000 port 0x3d404d00 irq 48
[    0.653912] ata26: SATA max UDMA/133 abar m16384@0x3d404000 port 0x3d404d80 irq 48
[    0.653913] ata27: SATA max UDMA/133 abar m16384@0x3d404000 port 0x3d404e00 irq 48
[    0.653914] ata28: SATA max UDMA/133 abar m16384@0x3d404000 port 0x3d404e80 irq 48
[    0.653915] ata29: SATA max UDMA/133 abar m16384@0x3d404000 port 0x3d404f00 irq 48
[    0.653916] ata30: SATA max UDMA/133 abar m16384@0x3d404000 port 0x3d404f80 irq 48
[    0.654803] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.654813] ehci-pci: EHCI PCI platform driver
[    0.654968] ehci-pci 0000:01:02.0: EHCI Host Controller
[    0.655113] ehci-pci 0000:01:02.0: new USB bus registered, assigned bus number 1
[    0.655228] ehci-pci 0000:01:02.0: irq 49, io mem 0x3d408000
[    0.678990] ehci-pci 0000:01:02.0: USB 2.0 started, EHCI 1.00
[    0.679197] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.19
[    0.679199] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.679201] usb usb1: Product: EHCI Host Controller
[    0.679202] usb usb1: Manufacturer: Linux 5.19.0-0.rc8.20220727git39c3c396f813.60.fc37.aarch64 ehci_hcd
[    0.679204] usb usb1: SerialNumber: 0000:01:02.0
[    0.679547] hub 1-0:1.0: USB hub found
[    0.679574] hub 1-0:1.0: 6 ports detected
[    0.680312] xhci_hcd 0000:0a:00.0: xHCI Host Controller
[    0.680449] xhci_hcd 0000:0a:00.0: new USB bus registered, assigned bus number 2
[    0.680559] xhci_hcd 0000:0a:00.0: hcc params 0x0388f081 hci version 0x100 quirks 0x0000000000000010
[    0.681065] xhci_hcd 0000:0a:00.0: xHCI Host Controller
[    0.681168] xhci_hcd 0000:0a:00.0: new USB bus registered, assigned bus number 3
[    0.681173] xhci_hcd 0000:0a:00.0: Host supports USB 3.1 Enhanced SuperSpeed
[    0.681314] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.19
[    0.681316] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.681318] usb usb2: Product: xHCI Host Controller
[    0.681319] usb usb2: Manufacturer: Linux 5.19.0-0.rc8.20220727git39c3c396f813.60.fc37.aarch64 xhci-hcd
[    0.681321] usb usb2: SerialNumber: 0000:0a:00.0
[    0.681579] hub 2-0:1.0: USB hub found
[    0.681616] hub 2-0:1.0: 4 ports detected
[    0.682006] usb usb3: We don't know the algorithms for LPM for this host, disabling LPM.
[    0.682062] usb usb3: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.19
[    0.682064] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.682065] usb usb3: Product: xHCI Host Controller
[    0.682067] usb usb3: Manufacturer: Linux 5.19.0-0.rc8.20220727git39c3c396f813.60.fc37.aarch64 xhci-hcd
[    0.682068] usb usb3: SerialNumber: 0000:0a:00.0
[    0.682305] hub 3-0:1.0: USB hub found
[    0.682323] hub 3-0:1.0: 4 ports detected
[    0.682753] usbcore: registered new interface driver usbserial_generic
[    0.682773] usbserial: USB Serial support registered for generic
[    0.682862] mousedev: PS/2 mouse device common for all mice
[    0.683126] rtc-efi rtc-efi.0: registered as rtc0
[    0.683145] rtc-efi rtc-efi.0: setting system clock to 2022-07-29T21:57:00 UTC (1659131820)
[    0.683434] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
[    0.683486] device-mapper: uevent: version 1.0.3
[    0.683684] device-mapper: ioctl: 4.46.0-ioctl (2022-02-22) initialised: dm-devel@redhat.com
[    0.684057] ledtrig-cpu: registered to indicate activity on CPUs
[    0.684888] [drm] Initialized simpledrm 1.0.0 20200625 for simple-framebuffer.0 on minor 0
[    0.685321] fbcon: Deferring console take-over
[    0.685323] simple-framebuffer simple-framebuffer.0: [drm] fb0: simpledrmdrmfb frame buffer device
[    0.685497] hid: raw HID events driver (C) Jiri Kosina
[    0.685575] usbcore: registered new interface driver usbhid
[    0.685576] usbhid: USB HID core driver
[    0.685959] drop_monitor: Initializing network drop monitor service
[    0.692209] Initializing XFRM netlink socket
[    0.692591] NET: Registered PF_INET6 protocol family
[    0.696936] modprobe (176) used greatest stack depth: 12544 bytes left
[    0.700617] Segment Routing with IPv6
[    0.700618] RPL Segment Routing with IPv6
[    0.700629] In-situ OAM (IOAM) with IPv6
[    0.700643] mip6: Mobile IPv6
[    0.700645] NET: Registered PF_PACKET protocol family
[    0.701075] registered taskstats version 1
[    0.701206] Loading compiled-in X.509 certificates
[    0.714437] Loaded X.509 cert 'Fedora kernel signing key: 02d4b25ecceca71e939575ac18ba52c29dac6ea9'
[    0.714796] zswap: loaded using pool lzo/zbud
[    0.714848] cryptomgr_test (183) used greatest stack depth: 11952 bytes left
[    0.715014] debug_vm_pgtable: [debug_vm_pgtable         ]: Validating architecture page table helpers
[    0.715208] page_owner is disabled
[    0.715418] Key type ._fscrypt registered
[    0.715420] Key type .fscrypt registered
[    0.715421] Key type fscrypt-provisioning registered
[    0.716514] Btrfs loaded, crc32c=crc32c-generic, assert=on, zoned=yes, fsverity=yes
[    0.716592] Key type big_key registered
[    0.716751] Key type encrypted registered
[    0.717297] integrity: Loading X.509 certificate: UEFI:db
[    0.730045] integrity: Loaded X.509 cert 'VMware, Inc.: 4ad8ba0472073d28127706ddc6ccb9050441bbc7'
[    0.730046] integrity: Loading X.509 certificate: UEFI:db
[    0.730156] integrity: Loaded X.509 cert 'VMware, Inc.: VMware Secure Boot Signing: 04597f3e1ffb240bba0ff0f05d5eb05f3e15f6d7'
[    0.730158] integrity: Loading X.509 certificate: UEFI:db
[    0.730194] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    0.730195] integrity: Loading X.509 certificate: UEFI:db
[    0.730215] integrity: Loaded X.509 cert 'Microsoft Windows Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    0.730640] ima: secureboot mode disabled
[    0.730646] ima: No TPM chip found, activating TPM-bypass!
[    0.730651] Loading compiled-in module X.509 certificates
[    0.730945] Loaded X.509 cert 'Fedora kernel signing key: 02d4b25ecceca71e939575ac18ba52c29dac6ea9'
[    0.730948] ima: Allocated hash algorithm: sha256
[    0.730966] ima: No architecture policies found
[    0.731013] evm: Initialising EVM extended attributes:
[    0.731014] evm: security.selinux
[    0.731015] evm: security.SMACK64 (disabled)
[    0.731016] evm: security.SMACK64EXEC (disabled)
[    0.731017] evm: security.SMACK64TRANSMUTE (disabled)
[    0.731018] evm: security.SMACK64MMAP (disabled)
[    0.731019] evm: security.apparmor (disabled)
[    0.731020] evm: security.ima
[    0.731021] evm: security.capability
[    0.731022] evm: HMAC attrs: 0x1
[    0.751581] cryptomgr_test (219) used greatest stack depth: 11824 bytes left
[    0.753645] alg: No test for 842 (842-scomp)
[    0.753695] alg: No test for 842 (842-generic)
[    0.763604] cryptomgr_test (275) used greatest stack depth: 11664 bytes left
[    0.968984] usb 1-1: new high-speed USB device number 2 using ehci-pci
[    0.969504] usb 2-1: new full-speed USB device number 2 using xhci_hcd
[    0.979260] ata30: SATA link down (SStatus 0 SControl 300)
[    0.979356] ata29: SATA link down (SStatus 0 SControl 300)
[    0.979398] ata28: SATA link down (SStatus 0 SControl 300)
[    0.979441] ata27: SATA link down (SStatus 0 SControl 300)
[    0.979482] ata26: SATA link down (SStatus 0 SControl 300)
[    0.979524] ata25: SATA link down (SStatus 0 SControl 300)
[    0.979564] ata24: SATA link down (SStatus 0 SControl 300)
[    0.979604] ata23: SATA link down (SStatus 0 SControl 300)
[    0.979709] ata22: SATA link down (SStatus 0 SControl 300)
[    0.979757] ata20: SATA link down (SStatus 0 SControl 300)
[    0.979807] ata19: SATA link down (SStatus 0 SControl 300)
[    0.979855] ata18: SATA link down (SStatus 0 SControl 300)
[    0.979901] ata21: SATA link down (SStatus 0 SControl 300)
[    0.979949] ata17: SATA link down (SStatus 0 SControl 300)
[    0.979995] ata15: SATA link down (SStatus 0 SControl 300)
[    0.980043] ata14: SATA link down (SStatus 0 SControl 300)
[    0.980092] ata16: SATA link down (SStatus 0 SControl 300)
[    0.980138] ata13: SATA link down (SStatus 0 SControl 300)
[    0.980186] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    0.980305] ata2.00: ATAPI: VMware Virtual SATA CDRW Drive, 00000001, max UDMA/33
[    0.980411] ata2.00: configured for UDMA/33
[    0.980488] ata5: SATA link down (SStatus 0 SControl 300)
[    0.980536] ata6: SATA link down (SStatus 0 SControl 300)
[    0.980581] ata1: SATA link down (SStatus 0 SControl 300)
[    0.981282] scsi 1:0:0:0: CD-ROM            NECVMWar VMware SATA CD01 1.00 PQ: 0 ANSI: 5
[    0.982479] sr 1:0:0:0: [sr0] scsi3-mmc drive: 1x/1x writer dvd-ram cd/rw xa/form2 cdda tray
[    0.982497] cdrom: Uniform CD-ROM driver Revision: 3.20
[    0.983169] ata9: SATA link down (SStatus 0 SControl 300)
[    0.983218] ata4: SATA link down (SStatus 0 SControl 300)
[    0.983266] ata3: SATA link down (SStatus 0 SControl 300)
[    0.983311] ata10: SATA link down (SStatus 0 SControl 300)
[    0.983359] ata7: SATA link down (SStatus 0 SControl 300)
[    0.983405] ata11: SATA link down (SStatus 0 SControl 300)
[    0.983452] ata12: SATA link down (SStatus 0 SControl 300)
[    0.983499] ata8: SATA link down (SStatus 0 SControl 300)
[    1.021151] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    1.021624] sr 1:0:0:0: Attached scsi generic sg0 type 5
[    1.031695] Freeing unused kernel memory: 9536K
[    1.057210] Checked W+X mappings: passed, no W+X pages found
[    1.057216] rodata_test: all tests were successful
[    1.057228] Run /init as init process
[    1.057231]   with arguments:
[    1.057233]     /init
[    1.057235]     rhgb
[    1.057237]   with environment:
[    1.057239]     HOME=/
[    1.057240]     TERM=linux
[    1.057242]     BOOT_IMAGE=(hd0,gpt2)/vmlinuz-5.19.0-0.rc8.20220727git39c3c396f813.60.fc37.aarch64
[    1.082979] systemd[1]: systemd 251.3-2.fc37 running in system mode (+PAM +AUDIT +SELINUX -APPARMOR +IMA +SMACK +SECCOMP -GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN -IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +XKBCOMMON +UTMP +SYSVINIT default-hierarchy=unified)
[    1.082986] systemd[1]: Detected virtualization vmware.
[    1.082993] systemd[1]: Detected architecture arm64.
[    1.082998] systemd[1]: Running in initial RAM disk.
[    1.083137] systemd[1]: No hostname configured, using default hostname.
[    1.083390] systemd[1]: Hostname set to <fedora>.
[    1.149273] usb 2-1: New USB device found, idVendor=0e0f, idProduct=0003, bcdDevice= 1.02
[    1.149277] usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    1.149279] usb 2-1: Product: VMware Virtual USB Mouse
[    1.149281] usb 2-1: Manufacturer: VMware
[    1.150352] input: VMware VMware Virtual USB Mouse as /devices/platform/40000000.pcie/pci0000:00/0000:00:16.0/0000:0a:00.0/usb2/2-1/2-1:1.0/0003:0E0F:0003.0001/input/input0
[    1.150668] hid-generic 0003:0E0F:0003.0001: input,hidraw0: USB HID v1.10 Mouse [VMware VMware Virtual USB Mouse] on usb-0000:0a:00.0-1/input0
[    1.151178] input: VMware VMware Virtual USB Mouse as /devices/platform/40000000.pcie/pci0000:00/0000:00:16.0/0000:0a:00.0/usb2/2-1/2-1:1.1/0003:0E0F:0003.0002/input/input1
[    1.151358] hid-generic 0003:0E0F:0003.0002: input,hidraw1: USB HID v1.10 Mouse [VMware VMware Virtual USB Mouse] on usb-0000:0a:00.0-1/input1
[    1.170857] systemd[1]: bpf-lsm: Failed to link program; assuming BPF LSM is not available
[    1.174777] usb 1-1: New USB device found, idVendor=0e0f, idProduct=000b, bcdDevice= 1.00
[    1.174780] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    1.174781] usb 1-1: Product: VMware Virtual USB Video Device
[    1.174783] usb 1-1: Manufacturer: VMware, Inc.
[    1.198495] systemd-fstab-g (285) used greatest stack depth: 11504 bytes left
[    1.204277] systemd-debug-g (284) used greatest stack depth: 11376 bytes left
[    1.298970] usb 2-2: new full-speed USB device number 3 using xhci_hcd
[    1.299608] systemd[1]: Queued start job for default target initrd.target.
[    1.299753] systemd[1]: Reached target initrd-usr-fs.target - Initrd /usr File System.
[    1.299842] systemd[1]: Reached target local-fs.target - Local File Systems.
[    1.299857] systemd[1]: Reached target slices.target - Slice Units.
[    1.299869] systemd[1]: Reached target swap.target - Swaps.
[    1.299880] systemd[1]: Reached target timers.target - Timer Units.
[    1.300119] systemd[1]: Listening on dbus.socket - D-Bus System Message Bus Socket.
[    1.300404] systemd[1]: Listening on systemd-journald-audit.socket - Journal Audit Socket.
[    1.300675] systemd[1]: Listening on systemd-journald-dev-log.socket - Journal Socket (/dev/log).
[    1.300956] systemd[1]: Listening on systemd-journald.socket - Journal Socket.
[    1.301248] systemd[1]: Listening on systemd-udevd-control.socket - udev Control Socket.
[    1.301447] systemd[1]: Listening on systemd-udevd-kernel.socket - udev Kernel Socket.
[    1.301458] systemd[1]: Reached target sockets.target - Socket Units.
[    1.304964] systemd[1]: Starting kmod-static-nodes.service - Create List of Static Device Nodes...
[    1.305074] systemd[1]: memstrack.service - Memstrack Anylazing Service was skipped because all trigger condition checks failed.
[    1.314027] systemd[1]: Starting systemd-journald.service - Journal Service...
[    1.329373] systemd[1]: Starting systemd-modules-load.service - Load Kernel Modules...
[    1.339333] systemd[1]: Starting systemd-sysusers.service - Create System Users...
[    1.354723] systemd[1]: Starting systemd-vconsole-setup.service - Setup Virtual Console...
[    1.367669] fuse: init (API version 7.36)
[    1.369568] systemd[1]: Finished kmod-static-nodes.service - Create List of Static Device Nodes.
[    1.423817] systemd[1]: Finished systemd-modules-load.service - Load Kernel Modules.
[    1.425884] audit: type=1130 audit(1659131821.230:2): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-modules-load comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    1.426059] systemd[1]: Starting systemd-sysctl.service - Apply Kernel Variables...
[    1.451275] systemd[1]: Finished systemd-sysusers.service - Create System Users.
[    1.451708] audit: type=1130 audit(1659131821.260:3): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-sysusers comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    1.453561] systemd[1]: Starting systemd-tmpfiles-setup-dev.service - Create Static Device Nodes in /dev...
[    1.470353] systemd[1]: Finished systemd-tmpfiles-setup-dev.service - Create Static Device Nodes in /dev.
[    1.470408] audit: type=1130 audit(1659131821.280:4): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-tmpfiles-setup-dev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    1.472154] systemd[1]: Finished systemd-sysctl.service - Apply Kernel Variables.
[    1.472180] audit: type=1130 audit(1659131821.280:5): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-sysctl comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    1.479565] usb 2-2: New USB device found, idVendor=0e0f, idProduct=0006, bcdDevice= 1.00
[    1.479568] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    1.479570] usb 2-2: Product: VMware Virtual USB Keyboard
[    1.479572] usb 2-2: Manufacturer: VMware
[    1.480540] input: VMware VMware Virtual USB Keyboard as /devices/platform/40000000.pcie/pci0000:00/0000:00:16.0/0000:0a:00.0/usb2/2-2/2-2:1.0/0003:0E0F:0006.0003/input/input2
[    1.550431] hid-generic 0003:0E0F:0006.0003: input,hidraw2: USB HID v1.10 Keyboard [VMware VMware Virtual USB Keyboard] on usb-0000:0a:00.0-2/input0
[    1.601372] systemd[1]: Finished systemd-vconsole-setup.service - Setup Virtual Console.
[    1.603403] audit: type=1130 audit(1659131821.410:6): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-vconsole-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    1.603595] systemd[1]: Starting dracut-cmdline-ask.service - dracut ask for additional cmdline parameters...
[    1.680284] systemd[1]: Finished dracut-cmdline-ask.service - dracut ask for additional cmdline parameters.
[    1.682429] audit: type=1130 audit(1659131821.490:7): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-cmdline-ask comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    1.682624] systemd[1]: Starting dracut-cmdline.service - dracut cmdline hook...
[    1.698994] usb 2-3: new full-speed USB device number 4 using xhci_hcd
[    1.733565] systemd[1]: Started systemd-journald.service - Journal Service.
[    1.735483] audit: type=1130 audit(1659131821.540:8): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    1.776044] audit: type=1130 audit(1659131821.580:9): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-tmpfiles-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    1.871577] audit: type=1130 audit(1659131821.680:10): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=dracut-cmdline comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[    1.879514] usb 2-3: New USB device found, idVendor=0e0f, idProduct=0002, bcdDevice= 1.00
[    1.879517] usb 2-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    1.879519] usb 2-3: Product: VMware Virtual USB Hub
[    1.879521] usb 2-3: Manufacturer: VMware, Inc.
[    1.879983] hub 2-3:1.0: USB hub found
[    1.880023] hub 2-3:1.0: 7 ports detected
[    2.028977] usb 2-4: new high-speed USB device number 5 using xhci_hcd
[    2.210062] usb 2-4: New USB device found, idVendor=0e0f, idProduct=0002, bcdDevice= 1.00
[    2.210065] usb 2-4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.210067] usb 2-4: Product: VMware Virtual USB Hub
[    2.210069] usb 2-4: Manufacturer: VMware, Inc.
[    2.210531] hub 2-4:1.0: USB hub found
[    2.210568] hub 2-4:1.0: 7 ports detected
[    2.717807] plymouthd (444) used greatest stack depth: 11360 bytes left
[    2.915169] cdrom_id (457) used greatest stack depth: 11008 bytes left
[    3.018397] uhci_hcd: USB Universal Host Controller Interface driver
[    3.018607] uhci_hcd 0000:01:00.0: UHCI Host Controller
[    3.077251] uhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 4
[    3.077263] uhci_hcd 0000:01:00.0: detected 2 ports
[    3.077322] uhci_hcd 0000:01:00.0: irq 53, io port 0x0000c000
[    3.080777] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.19
[    3.080780] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.080782] usb usb4: Product: UHCI Host Controller
[    3.080783] usb usb4: Manufacturer: Linux 5.19.0-0.rc8.20220727git39c3c396f813.60.fc37.aarch64 uhci_hcd
[    3.080784] usb usb4: SerialNumber: 0000:01:00.0
[    3.081225] hub 4-0:1.0: USB hub found
[    3.085758] hub 4-0:1.0: 2 ports detected
[    3.306979] e1000e: Intel(R) PRO/1000 Network Driver
[    3.306982] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    3.307120] e1000e 0000:02:00.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[    3.342357] vmwgfx 0000:00:0f.0: [drm] Register MMIO at 0x0x000000003d000000 size is 4096 kiB
[    3.342380] vmwgfx 0000:00:0f.0: [drm] VRAM at 0x0000000070000000 size is 131072 kiB
[    3.342384] vmwgfx 0000:00:0f.0: [drm] Running on SVGA version 3.
[    3.342387] vmwgfx 0000:00:0f.0: [drm] Capabilities: cursor, cursor bypass, alpha cursor, 3D, pitchlock, irq mask, traces, command buffers, command buffers 2, gbobject, dx, hp cmd queue, no bb restriction, cap2 register, 
[    3.342390] vmwgfx 0000:00:0f.0: [drm] Capabilities2: grow otable, intra surface copy, dx2, gb memsize 2, screendma reg, otable ptdepth2, non ms to ms stretchblt, cursor mob, mshint, cb max size 4mb, dx3, frame type, trace full fb, extra regs, lo staging, 
[    3.342392] vmwgfx 0000:00:0f.0: [drm] DMA map mode: Caching DMA mappings.
[    3.342421] vmwgfx 0000:00:0f.0: [drm] Legacy memory limits: VRAM = 4096 kB, FIFO = 256 kB, surface = 524288 kB
[    3.342422] vmwgfx 0000:00:0f.0: [drm] MOB limits: max mob size = 1048576 kB, max mob pages = 131072
[    3.342424] vmwgfx 0000:00:0f.0: [drm] Maximum display memory size is 262144 kiB
[    3.360470] nvme nvme0: pci function 0000:12:00.0
[    3.361930] nvme nvme0: 1/0/0 default/read/poll queues
[    3.364261]  nvme0n1: p1 p2 p3
[    3.373732] vmwgfx 0000:00:0f.0: [drm] No GMR memory available. Graphics memory resources are very limited.
[    3.379400] usb 4-1: new full-speed USB device number 2 using uhci_hcd
[    3.380375] e1000e 0000:02:00.0 0000:02:00.0 (uninitialized): registered PHC clock
[    3.414244] vmwgfx 0000:00:0f.0: [drm] Screen Target display unit initialized
[    3.414816] vmwgfx 0000:00:0f.0: [drm] Using command buffers with DMA pool.
[    3.414828] vmwgfx 0000:00:0f.0: [drm] Available shader model: SM_5_1X.
[    3.415391] fbcon: Deferring console take-over
[    3.422284] [drm] Initialized vmwgfx 2.20.0 20211206 for 0000:00:0f.0 on minor 0
[    3.444448] e1000e 0000:02:00.0 eth0: (PCI Express:2.5GT/s:Width x1) 00:0c:29:93:56:e5
[    3.444451] e1000e 0000:02:00.0 eth0: Intel(R) PRO/1000 Network Connection
[    3.444458] e1000e 0000:02:00.0 eth0: MAC: 3, PHY: 8, PBA No: 000000-000
[    3.462543] e1000e 0000:02:00.0 ens160: renamed from eth0
[    3.544558] BTRFS: device label fedora_localhost-live devid 1 transid 75 /dev/nvme0n1p3 scanned by systemd-udevd (436)
[    3.574569] usb 4-1: New USB device found, idVendor=0e0f, idProduct=0008, bcdDevice= 1.00
[    3.574573] usb 4-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    3.574576] usb 4-1: Product: Virtual Bluetooth Adapter
[    3.574578] usb 4-1: Manufacturer: VMware
[    3.574580] usb 4-1: SerialNumber: 000650268328
[    3.719091] usb 4-2: new full-speed USB device number 3 using uhci_hcd
[    3.909131] usb 4-2: New USB device found, idVendor=0e0f, idProduct=0002, bcdDevice= 1.00
[    3.909142] usb 4-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.909146] usb 4-2: Product: VMware Virtual USB Hub
[    3.909149] usb 4-2: Manufacturer: VMware, Inc.
[    3.914623] hub 4-2:1.0: USB hub found
[    3.916727] hub 4-2:1.0: 7 ports detected
[    4.022949] fsck (496) used greatest stack depth: 10896 bytes left
[    4.042680] BTRFS info (device nvme0n1p3): flagging fs with big metadata feature
[    4.042685] BTRFS info (device nvme0n1p3): using free space tree
[    4.042686] BTRFS info (device nvme0n1p3): has skinny extents
[    4.046846] BTRFS info (device nvme0n1p3): enabling ssd optimizations
[    4.050297] mount (498) used greatest stack depth: 10256 bytes left
[    4.504872] systemd-udevd (428) used greatest stack depth: 9984 bytes left
[    4.600281] systemd-udevd (437) used greatest stack depth: 9616 bytes left
[    4.793384] systemd-journald[319]: Received SIGTERM from PID 1 (systemd).
[    5.068423] SELinux:  policy capability network_peer_controls=1
[    5.068427] SELinux:  policy capability open_perms=1
[    5.068428] SELinux:  policy capability extended_socket_class=1
[    5.068429] SELinux:  policy capability always_check_network=0
[    5.068430] SELinux:  policy capability cgroup_seclabel=1
[    5.068431] SELinux:  policy capability nnp_nosuid_transition=1
[    5.068432] SELinux:  policy capability genfs_seclabel_symlinks=1
[    5.068433] SELinux:  policy capability ioctl_skip_cloexec=0
[    5.148604] systemd[1]: Successfully loaded SELinux policy in 188.603ms.
[    5.190846] systemd[1]: Relabelled /dev, /dev/shm, /run, /sys/fs/cgroup in 32.310ms.
[    5.195436] systemd[1]: systemd 251.3-2.fc37 running in system mode (+PAM +AUDIT +SELINUX -APPARMOR +IMA +SMACK +SECCOMP -GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN -IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +XKBCOMMON +UTMP +SYSVINIT default-hierarchy=unified)
[    5.195441] systemd[1]: Detected virtualization vmware.
[    5.195448] systemd[1]: Detected architecture arm64.
[    5.196049] systemd[1]: Hostname set to <vmware>.
[    5.205765] kauditd_printk_skb: 45 callbacks suppressed
[    5.205767] audit: type=1334 audit(1659131825.010:56): prog-id=30 op=LOAD
[    5.205799] audit: type=1334 audit(1659131825.010:57): prog-id=0 op=UNLOAD
[    5.205871] audit: type=1334 audit(1659131825.010:58): prog-id=31 op=LOAD
[    5.205895] audit: type=1334 audit(1659131825.010:59): prog-id=0 op=UNLOAD
[    5.207982] audit: type=1334 audit(1659131825.010:60): prog-id=32 op=LOAD
[    5.208007] audit: type=1334 audit(1659131825.010:61): prog-id=0 op=UNLOAD
[    5.208163] audit: type=1334 audit(1659131825.010:62): prog-id=33 op=LOAD
[    5.208189] audit: type=1334 audit(1659131825.010:63): prog-id=0 op=UNLOAD
[    5.208405] audit: type=1334 audit(1659131825.010:64): prog-id=34 op=LOAD
[    5.208428] audit: type=1334 audit(1659131825.010:65): prog-id=0 op=UNLOAD
[    5.290375] systemd[1]: bpf-lsm: Failed to link program; assuming BPF LSM is not available
[    5.395538] flatpak (580) used greatest stack depth: 8464 bytes left
[    5.618160] random: lvmconfig: uninitialized urandom read (4 bytes read)
[    5.635365] random: zram-generator: uninitialized urandom read (16 bytes read)
[    5.649049] systemd-gpt-auto-generator[596]: Failed to dissect: Permission denied
[    5.649201] systemd-sysv-generator[602]: SysV service '/etc/rc.d/init.d/livesys' lacks a native systemd unit file. Automatically generating a unit file for compatibility. Please update package to include a native systemd unit file, in order to make it more safe and robust.
[    5.649341] systemd-sysv-generator[602]: SysV service '/etc/rc.d/init.d/livesys-late' lacks a native systemd unit file. Automatically generating a unit file for compatibility. Please update package to include a native systemd unit file, in order to make it more safe and robust.
[    5.655449] systemd[581]: /usr/lib/systemd/system-generators/systemd-gpt-auto-generator failed with exit status 1.
[   15.979090] random: crng init done
[   16.008863] zram: Added device: zram0
[   16.156713] kauditd_printk_skb: 27 callbacks suppressed
[   16.156715] audit: type=1334 audit(1659131835.960:91): prog-id=47 op=LOAD
[   16.156795] audit: type=1334 audit(1659131835.960:92): prog-id=0 op=UNLOAD
[   16.156989] audit: type=1334 audit(1659131835.960:93): prog-id=48 op=LOAD
[   16.157077] audit: type=1334 audit(1659131835.960:94): prog-id=49 op=LOAD
[   16.157150] audit: type=1334 audit(1659131835.960:95): prog-id=0 op=UNLOAD
[   16.157196] audit: type=1334 audit(1659131835.960:96): prog-id=0 op=UNLOAD
[   16.159589] audit: type=1131 audit(1659131835.970:97): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   16.160883] systemd[1]: initrd-switch-root.service: Deactivated successfully.
[   16.161410] systemd[1]: Stopped initrd-switch-root.service - Switch Root.
[   16.161669] audit: type=1130 audit(1659131835.970:98): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=initrd-switch-root comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   16.161701] audit: type=1131 audit(1659131835.970:99): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=system_u:system_r:init_t:s0 msg='unit=initrd-switch-root comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
[   16.162062] systemd[1]: systemd-journald.service: Scheduled restart job, restart counter is at 1.
[   16.163148] systemd[1]: Created slice machine.slice - Virtual Machine and Container Slice.
[   16.164016] systemd[1]: Created slice system-getty.slice - Slice /system/getty.
[   16.164919] systemd[1]: Created slice system-modprobe.slice - Slice /system/modprobe.
[   16.165775] systemd[1]: Created slice system-systemd\x2dfsck.slice - Slice /system/systemd-fsck.
[   16.166649] systemd[1]: Created slice system-systemd\x2dzram\x2dsetup.slice - Slice /system/systemd-zram-setup.
[   16.167654] systemd[1]: Created slice user.slice - User and Session Slice.
[   16.167745] systemd[1]: systemd-ask-password-console.path - Dispatch Password Requests to Console Directory Watch was skipped because of a failed condition check (ConditionPathExists=!/run/plymouth/pid).
[   16.167967] systemd[1]: Started systemd-ask-password-wall.path - Forward Password Requests to Wall Directory Watch.
[   16.168675] systemd[1]: Set up automount proc-sys-fs-binfmt_misc.automount - Arbitrary Executable File Formats File System Automount Point.
[   16.168771] systemd[1]: Reached target cryptsetup.target - Local Encrypted Volumes.
[   16.168848] systemd[1]: Reached target getty.target - Login Prompts.
[   16.168925] systemd[1]: Stopped target initrd-switch-root.target - Switch Root.
[   16.169380] systemd[1]: Stopped target initrd-fs.target - Initrd File Systems.
[   16.169457] systemd[1]: Stopped target initrd-root-fs.target - Initrd Root File System.
[   16.169544] systemd[1]: Reached target integritysetup.target - Local Integrity Protected Volumes.
[   16.169649] systemd[1]: Reached target slices.target - Slice Units.
[   16.169747] systemd[1]: Reached target veritysetup.target - Local Verity Protected Volumes.
[   16.170396] systemd[1]: Listening on dm-event.socket - Device-mapper event daemon FIFOs.
[   16.171951] systemd[1]: Listening on lvm2-lvmpolld.socket - LVM2 poll daemon socket.
[   16.173314] systemd[1]: Listening on systemd-coredump.socket - Process Core Dump Socket.
[   16.173619] systemd[1]: Listening on systemd-initctl.socket - initctl Compatibility Named Pipe.
[   16.174386] systemd[1]: Listening on systemd-oomd.socket - Userspace Out-Of-Memory (OOM) Killer Socket.
[   16.176564] systemd[1]: Listening on systemd-udevd-control.socket - udev Control Socket.
[   16.177161] systemd[1]: Listening on systemd-udevd-kernel.socket - udev Kernel Socket.
[   16.177945] systemd[1]: Listening on systemd-userdbd.socket - User Database Manager Socket.
[   16.180067] audit: type=1334 audit(1659131835.990:100): prog-id=0 op=UNLOAD
[   16.181992] systemd[1]: Mounting dev-hugepages.mount - Huge Pages File System...
[   16.185922] systemd[1]: Mounting dev-mqueue.mount - POSIX Message Queue File System...
[   16.199603] systemd[1]: Mounting sys-kernel-debug.mount - Kernel Debug File System...
[   16.204971] systemd[1]: Mounting sys-kernel-tracing.mount - Kernel Trace File System...
[   16.209463] systemd[1]: auth-rpcgss-module.service - Kernel Module supporting RPCSEC_GSS was skipped because of a failed condition check (ConditionPathExists=/etc/krb5.keytab).
[   16.220652] systemd[1]: Starting kmod-static-nodes.service - Create List of Static Device Nodes...
[   16.229702] systemd[1]: Starting lvm2-monitor.service - Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
[   16.232294] systemd[1]: Starting modprobe@configfs.service - Load Kernel Module configfs...
[   16.247758] systemd[1]: Starting modprobe@drm.service - Load Kernel Module drm...
[   16.269729] systemd[1]: Starting modprobe@fuse.service - Load Kernel Module fuse...
[   16.279858] systemd[1]: Starting nfs-convert.service - Preprocess NFS configuration convertion...
[   16.280016] systemd[1]: plymouth-switch-root.service: Deactivated successfully.
[   16.280158] systemd[1]: Stopped plymouth-switch-root.service - Plymouth switch root service.
[   16.280654] systemd[1]: systemd-fsck-root.service: Deactivated successfully.
[   16.280789] systemd[1]: Stopped systemd-fsck-root.service - File System Check on Root Device.
[   16.281251] systemd[1]: Stopped systemd-journald.service - Journal Service.
[   16.291011] systemd[1]: Starting systemd-journald.service - Journal Service...
[   16.318753] systemd[1]: Starting systemd-modules-load.service - Load Kernel Modules...
[   16.322599] systemd[1]: Starting systemd-network-generator.service - Generate network units from Kernel command line...
[   16.349243] systemd[1]: Starting systemd-remount-fs.service - Remount Root and Kernel File Systems...
[   16.349474] systemd[1]: systemd-repart.service - Repartition Root Disk was skipped because all trigger condition checks failed.
[   16.356946] systemd[1]: Starting systemd-udev-trigger.service - Coldplug All udev Devices...
[   16.371161] systemd[1]: Mounted dev-hugepages.mount - Huge Pages File System.
[   16.385901] systemd[1]: Started systemd-journald.service - Journal Service.
[   16.401666] BTRFS info (device nvme0n1p3: state M): use zstd compression, level 1
[   16.401671] BTRFS info (device nvme0n1p3: state M): using free space tree
[   16.522932] systemd-journald[623]: Received client request to flush runtime journal.
[   17.376268] zram0: detected capacity change from 0 to 7944192
[   17.448616] Adding 3972092k swap on /dev/zram0.  Priority:100 extents:1 across:3972092k SSDscFS
[   18.124619] EXT4-fs (nvme0n1p2): mounted filesystem with ordered data mode. Quota mode: none.
[   18.268817] vmw_vmci 0000:00:00.7: enabling device (0000 -> 0003)
[   18.268853] vmw_vmci 0000:00:00.7: MMIO register access is available
[   18.296939] vmw_vmci 0000:00:00.7: Using capabilities 0x2c
[   18.305524] Guest personality initialized and is active
[   18.307536] VMCI host device registered (name=vmci, major=10, minor=124)
[   18.307538] Initialized host personality
[   18.791792] mc: Linux media interface: v0.10
[   18.968832] RPC: Registered named UNIX socket transport module.
[   18.968836] RPC: Registered udp transport module.
[   18.968837] RPC: Registered tcp transport module.
[   18.968838] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   19.926162] NET: Registered PF_VSOCK protocol family
[   19.997253] videodev: Linux video capture interface: v2.00
[   20.264639] BUG: sleeping function called from invalid context at drivers/misc/vmw_vmci/vmci_guest.c:145
[   20.264643] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 762, name: vmtoolsd
[   20.264645] preempt_count: 101, expected: 0
[   20.264646] RCU nest depth: 0, expected: 0
[   20.264647] 1 lock held by vmtoolsd/762:
[   20.264648]  #0: ffff0000874ae440 (sk_lock-AF_VSOCK){+.+.}-{0:0}, at: vsock_connect+0x60/0x330 [vsock]
[   20.264658] Preemption disabled at:
[   20.264659] [<ffff80000151d7d8>] vmci_send_datagram+0x44/0xa0 [vmw_vmci]
[   20.264665] CPU: 0 PID: 762 Comm: vmtoolsd Not tainted 5.19.0-0.rc8.20220727git39c3c396f813.60.fc37.aarch64 #1
[   20.264667] Hardware name: VMware, Inc. VBSA/VBSA, BIOS VEFI 12/31/2020
[   20.264668] Call trace:
[   20.264669]  dump_backtrace+0xc4/0x130
[   20.264672]  show_stack+0x24/0x80
[   20.264673]  dump_stack_lvl+0x88/0xb4
[   20.264676]  dump_stack+0x18/0x34
[   20.264677]  __might_resched+0x1a0/0x280
[   20.264679]  __might_sleep+0x58/0x90
[   20.264681]  vmci_read_data+0x74/0x120 [vmw_vmci]
[   20.264683]  vmci_dispatch_dgs+0x64/0x204 [vmw_vmci]
[   20.264686]  tasklet_action_common.constprop.0+0x13c/0x150
[   20.264688]  tasklet_action+0x40/0x50
[   20.264689]  __do_softirq+0x23c/0x6b4
[   20.264690]  __irq_exit_rcu+0x104/0x214
[   20.264691]  irq_exit_rcu+0x1c/0x50
[   20.264693]  el1_interrupt+0x38/0x6c
[   20.264695]  el1h_64_irq_handler+0x18/0x24
[   20.264696]  el1h_64_irq+0x68/0x6c
[   20.264697]  preempt_count_sub+0xa4/0xe0
[   20.264698]  _raw_spin_unlock_irqrestore+0x64/0xb0
[   20.264701]  vmci_send_datagram+0x7c/0xa0 [vmw_vmci]
[   20.264703]  vmci_datagram_dispatch+0x84/0x100 [vmw_vmci]
[   20.264706]  vmci_datagram_send+0x2c/0x40 [vmw_vmci]
[   20.264709]  vmci_transport_send_control_pkt+0xb8/0x120 [vmw_vsock_vmci_transport]
[   20.264711]  vmci_transport_connect+0x40/0x7c [vmw_vsock_vmci_transport]
[   20.264713]  vsock_connect+0x278/0x330 [vsock]
[   20.264715]  __sys_connect_file+0x8c/0xc0
[   20.264718]  __sys_connect+0x84/0xb4
[   20.264720]  __arm64_sys_connect+0x2c/0x3c
[   20.264721]  invoke_syscall+0x78/0x100
[   20.264723]  el0_svc_common.constprop.0+0x68/0x124
[   20.264724]  do_el0_svc+0x38/0x4c
[   20.264725]  el0_svc+0x60/0x180
[   20.264726]  el0t_64_sync_handler+0x11c/0x150
[   20.264728]  el0t_64_sync+0x190/0x194
[   20.295890] Bluetooth: Core ver 2.22
[   20.295975] NET: Registered PF_BLUETOOTH protocol family
[   20.295977] Bluetooth: HCI device and connection manager initialized
[   20.296004] Bluetooth: HCI socket layer initialized
[   20.296007] Bluetooth: L2CAP socket layer initialized
[   20.296030] Bluetooth: SCO socket layer initialized
[   20.633697] NET: Registered PF_QIPCRTR protocol family
[   21.299110] usb 1-1: Found UVC 1.00 device VMware Virtual USB Video Device (0e0f:000b)
[   21.362604] usbcore: registered new interface driver btusb
[   21.371516] usbcore: registered new interface driver uvcvideo
[   21.413084] Bluetooth: hci0: unexpected cc 0x0c12 length: 2 < 3
[   21.413096] Bluetooth: hci0: Opcode 0x c12 failed: -38
[   21.558306] snd_hda_intel 0000:01:01.0: enabling device (0000 -> 0002)
[   21.558335] snd_hda_intel 0000:01:01.0: Force to snoop mode by module option
[   21.566804] snd_hda_intel 0000:01:01.0: CORB reset timeout#1, CORBRP = 0
[   21.664139] snd_hda_codec_generic hdaudioC0D0: autoconfig for Generic: line_outs=4 (0x14/0x15/0x16/0x17/0x0) type:line
[   21.664144] snd_hda_codec_generic hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   21.664145] snd_hda_codec_generic hdaudioC0D0:    hp_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   21.664147] snd_hda_codec_generic hdaudioC0D0:    mono: mono_out=0x0
[   21.664148] snd_hda_codec_generic hdaudioC0D0:    inputs:
[   21.664150] snd_hda_codec_generic hdaudioC0D0:      Mic=0x18
[   21.701281] input: HD-Audio Generic Mic as /devices/platform/40000000.pcie/pci0000:00/0000:00:11.0/0000:01:01.0/sound/card0/input3
[   21.701594] input: HD-Audio Generic Line Out Front as /devices/platform/40000000.pcie/pci0000:00/0000:00:11.0/0000:01:01.0/sound/card0/input4
[   21.701729] input: HD-Audio Generic Line Out Surround as /devices/platform/40000000.pcie/pci0000:00/0000:00:11.0/0000:01:01.0/sound/card0/input5
[   21.701869] input: HD-Audio Generic Line Out CLFE as /devices/platform/40000000.pcie/pci0000:00/0000:00:11.0/0000:01:01.0/sound/card0/input6
[   21.702020] input: HD-Audio Generic Line Out Side as /devices/platform/40000000.pcie/pci0000:00/0000:00:11.0/0000:01:01.0/sound/card0/input7
[   21.770576] e1000e 0000:02:00.0 ens160: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None
[   21.770937] IPv6: ADDRCONF(NETDEV_CHANGE): ens160: link becomes ready
[   22.274899] BUG: sleeping function called from invalid context at drivers/misc/vmw_vmci/vmci_guest.c:145
[   22.274903] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 861, name: nfsrahead
[   22.274905] preempt_count: 100, expected: 0
[   22.274906] RCU nest depth: 0, expected: 0
[   22.274907] no locks held by nfsrahead/861.
[   22.274909] Preemption disabled at:
[   22.274910] [<ffff800008170318>] __do_softirq+0x98/0x6b4
[   22.274915] CPU: 0 PID: 861 Comm: nfsrahead Tainted: G        W        --------  ---  5.19.0-0.rc8.20220727git39c3c396f813.60.fc37.aarch64 #1
[   22.274917] Hardware name: VMware, Inc. VBSA/VBSA, BIOS VEFI 12/31/2020
[   22.274918] Call trace:
[   22.274919]  dump_backtrace+0xc4/0x130
[   22.274920]  show_stack+0x24/0x80
[   22.274921]  dump_stack_lvl+0x88/0xb4
[   22.274924]  dump_stack+0x18/0x34
[   22.274925]  __might_resched+0x1a0/0x280
[   22.274927]  __might_sleep+0x58/0x90
[   22.274928]  vmci_read_data+0x74/0x120 [vmw_vmci]
[   22.274934]  vmci_dispatch_dgs+0x64/0x204 [vmw_vmci]
[   22.274937]  tasklet_action_common.constprop.0+0x13c/0x150
[   22.274939]  tasklet_action+0x40/0x50
[   22.274940]  __do_softirq+0x23c/0x6b4
[   22.274941]  __irq_exit_rcu+0x104/0x214
[   22.274943]  irq_exit_rcu+0x1c/0x50
[   22.274944]  el0_interrupt+0x84/0x1f0
[   22.274946]  __el0_irq_handler_common+0x18/0x24
[   22.274947]  el0t_64_irq_handler+0x10/0x20
[   22.274949]  el0t_64_irq+0x190/0x194
[   22.796448] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   22.796451] Bluetooth: BNEP filters: protocol multicast
[   22.796459] Bluetooth: BNEP socket layer initialized
[   27.183154] rfkill: input handler disabled
[   28.427488] vmwgfx 0000:00:0f.0: [drm] Using CursorMob mobid 125, max dimension 2048
[   28.427579] vmwgfx 0000:00:0f.0: [drm] Using CursorMob mobid 126, max dimension 2048
[   41.266150] BUG: sleeping function called from invalid context at drivers/misc/vmw_vmci/vmci_guest.c:145
[   41.266172] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 762, name: vmtoolsd
[   41.266178] preempt_count: 101, expected: 0
[   41.266182] RCU nest depth: 0, expected: 0
[   41.266187] 1 lock held by vmtoolsd/762:
[   41.266192]  #0: ffff0000874abb00 (sk_lock-AF_VSOCK){+.+.}-{0:0}, at: vsock_connectible_sendmsg+0x5c/0x310 [vsock]
[   41.266235] Preemption disabled at:
[   41.266239] [<ffff80000151d7d8>] vmci_send_datagram+0x44/0xa0 [vmw_vmci]
[   41.266265] CPU: 0 PID: 762 Comm: vmtoolsd Tainted: G        W        --------  ---  5.19.0-0.rc8.20220727git39c3c396f813.60.fc37.aarch64 #1
[   41.266272] Hardware name: VMware, Inc. VBSA/VBSA, BIOS VEFI 12/31/2020
[   41.266276] Call trace:
[   41.266279]  dump_backtrace+0xc4/0x130
[   41.266289]  show_stack+0x24/0x80
[   41.266294]  dump_stack_lvl+0x88/0xb4
[   41.266302]  dump_stack+0x18/0x34
[   41.266306]  __might_resched+0x1a0/0x280
[   41.266313]  __might_sleep+0x58/0x90
[   41.266318]  vmci_read_data+0x74/0x120 [vmw_vmci]
[   41.266330]  vmci_dispatch_dgs+0x64/0x204 [vmw_vmci]
[   41.266340]  tasklet_action_common.constprop.0+0x13c/0x150
[   41.266348]  tasklet_action+0x40/0x50
[   41.266352]  __do_softirq+0x23c/0x6b4
[   41.266356]  __irq_exit_rcu+0x104/0x214
[   41.266361]  irq_exit_rcu+0x1c/0x50
[   41.266365]  el1_interrupt+0x38/0x6c
[   41.266372]  el1h_64_irq_handler+0x18/0x24
[   41.266379]  el1h_64_irq+0x68/0x6c
[   41.266382]  preempt_count_sub+0x3c/0xe0
[   41.266387]  _raw_spin_unlock_irqrestore+0x64/0xb0
[   41.266396]  vmci_send_datagram+0x7c/0xa0 [vmw_vmci]
[   41.266406]  vmci_datagram_dispatch+0x84/0x100 [vmw_vmci]
[   41.266417]  vmci_datagram_send+0x2c/0x40 [vmw_vmci]
[   41.266428]  vmci_transport_send_control_pkt+0xb8/0x120 [vmw_vsock_vmci_transport]
[   41.266438]  vmci_transport_send_wrote+0x38/0x44 [vmw_vsock_vmci_transport]
[   41.266445]  vmci_transport_notify_pkt_send_post_enqueue+0x7c/0xc0 [vmw_vsock_vmci_transport]
[   41.266452]  vmci_transport_notify_send_post_enqueue+0x28/0x3c [vmw_vsock_vmci_transport]
[   41.266459]  vsock_connectible_sendmsg+0x2b4/0x310 [vsock]
[   41.266467]  sock_sendmsg+0x60/0x70
[   41.266478]  __sys_sendto+0xc4/0x130
[   41.266485]  __arm64_sys_sendto+0x34/0x44
[   41.266491]  invoke_syscall+0x78/0x100
[   41.266495]  el0_svc_common.constprop.0+0x68/0x124
[   41.266499]  do_el0_svc+0x38/0x4c
[   41.266503]  el0_svc+0x60/0x180
[   41.266509]  el0t_64_sync_handler+0x11c/0x150
[   41.266515]  el0t_64_sync+0x190/0x194
[   50.571287] BUG: sleeping function called from invalid context at drivers/misc/vmw_vmci/vmci_guest.c:145
[   50.571311] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper/0
[   50.571315] preempt_count: 101, expected: 0
[   50.571317] RCU nest depth: 0, expected: 0
[   50.571321] no locks held by swapper/0/0.
[   50.571324] Preemption disabled at:
[   50.571327] [<ffff80000932ca40>] schedule_preempt_disabled+0x2c/0x3c
[   50.571349] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W        --------  ---  5.19.0-0.rc8.20220727git39c3c396f813.60.fc37.aarch64 #1
[   50.571353] Hardware name: VMware, Inc. VBSA/VBSA, BIOS VEFI 12/31/2020
[   50.571355] Call trace:
[   50.571357]  dump_backtrace+0xc4/0x130
[   50.571365]  show_stack+0x24/0x80
[   50.571368]  dump_stack_lvl+0x88/0xb4
[   50.571373]  dump_stack+0x18/0x34
[   50.571376]  __might_resched+0x1a0/0x280
[   50.571383]  __might_sleep+0x58/0x90
[   50.571386]  vmci_read_data+0x74/0x120 [vmw_vmci]
[   50.571398]  vmci_dispatch_dgs+0x64/0x204 [vmw_vmci]
[   50.571405]  tasklet_action_common.constprop.0+0x13c/0x150
[   50.571411]  tasklet_action+0x40/0x50
[   50.571413]  __do_softirq+0x23c/0x6b4
[   50.571416]  __irq_exit_rcu+0x104/0x214
[   50.571419]  irq_exit_rcu+0x1c/0x50
[   50.571422]  el1_interrupt+0x38/0x6c
[   50.571428]  el1h_64_irq_handler+0x18/0x24
[   50.571432]  el1h_64_irq+0x68/0x6c
[   50.571435]  arch_cpu_idle+0x1c/0x2c
[   50.571438]  cpuidle_idle_call+0x158/0x1a4
[   50.571444]  do_idle+0x100/0x13c
[   50.571447]  cpu_startup_entry+0x30/0x3c
[   50.571450]  rest_init+0x110/0x190
[   50.571453]  arch_post_acpi_subsys_init+0x0/0x30
[   50.571461]  start_kernel+0x4a4/0x4c0
[   50.571464]  __primary_switched+0xc0/0xc8
[   61.263607] BUG: sleeping function called from invalid context at drivers/misc/vmw_vmci/vmci_guest.c:145
[   61.263621] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper/0
[   61.263625] preempt_count: 101, expected: 0
[   61.263628] RCU nest depth: 0, expected: 0
[   61.263632] no locks held by swapper/0/0.
[   61.263635] Preemption disabled at:
[   61.263638] [<ffff80000932ca40>] schedule_preempt_disabled+0x2c/0x3c
[   61.263655] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W        --------  ---  5.19.0-0.rc8.20220727git39c3c396f813.60.fc37.aarch64 #1
[   61.263660] Hardware name: VMware, Inc. VBSA/VBSA, BIOS VEFI 12/31/2020
[   61.263663] Call trace:
[   61.263666]  dump_backtrace+0xc4/0x130
[   61.263673]  show_stack+0x24/0x80
[   61.263676]  dump_stack_lvl+0x88/0xb4
[   61.263681]  dump_stack+0x18/0x34
[   61.263683]  __might_resched+0x1a0/0x280
[   61.263691]  __might_sleep+0x58/0x90
[   61.263695]  vmci_read_data+0x74/0x120 [vmw_vmci]
[   61.263712]  vmci_dispatch_dgs+0x64/0x204 [vmw_vmci]
[   61.263721]  tasklet_action_common.constprop.0+0x13c/0x150
[   61.263726]  tasklet_action+0x40/0x50
[   61.263730]  __do_softirq+0x23c/0x6b4
[   61.263733]  __irq_exit_rcu+0x104/0x214
[   61.263736]  irq_exit_rcu+0x1c/0x50
[   61.263740]  el1_interrupt+0x38/0x6c
[   61.263746]  el1h_64_irq_handler+0x18/0x24
[   61.263751]  el1h_64_irq+0x68/0x6c
[   61.263754]  default_idle_call+0x50/0xc4
[   61.263759]  cpuidle_idle_call+0x158/0x1a4
[   61.263766]  do_idle+0x100/0x13c
[   61.263770]  cpu_startup_entry+0x30/0x3c
[   61.263774]  rest_init+0x110/0x190
[   61.263779]  arch_post_acpi_subsys_init+0x0/0x30
[   61.263788]  start_kernel+0x4a4/0x4c0
[   61.263792]  __primary_switched+0xc0/0xc8
[   80.594690] BUG: sleeping function called from invalid context at drivers/misc/vmw_vmci/vmci_guest.c:145
[   80.594715] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper/0
[   80.594723] preempt_count: 101, expected: 0
[   80.594730] RCU nest depth: 0, expected: 0
[   80.594739] no locks held by swapper/0/0.
[   80.594746] Preemption disabled at:
[   80.594753] [<ffff80000932ca40>] schedule_preempt_disabled+0x2c/0x3c
[   80.594782] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W        --------  ---  5.19.0-0.rc8.20220727git39c3c396f813.60.fc37.aarch64 #1
[   80.594793] Hardware name: VMware, Inc. VBSA/VBSA, BIOS VEFI 12/31/2020
[   80.594798] Call trace:
[   80.594803]  dump_backtrace+0xc4/0x130
[   80.594815]  show_stack+0x24/0x80
[   80.594822]  dump_stack_lvl+0x88/0xb4
[   80.594831]  dump_stack+0x18/0x34
[   80.594837]  __might_resched+0x1a0/0x280
[   80.594849]  __might_sleep+0x58/0x90
[   80.594856]  vmci_read_data+0x74/0x120 [vmw_vmci]
[   80.594881]  vmci_dispatch_dgs+0x64/0x204 [vmw_vmci]
[   80.594896]  tasklet_action_common.constprop.0+0x13c/0x150
[   80.594907]  tasklet_action+0x40/0x50
[   80.594913]  __do_softirq+0x23c/0x6b4
[   80.594920]  __irq_exit_rcu+0x104/0x214
[   80.594926]  irq_exit_rcu+0x1c/0x50
[   80.594932]  el1_interrupt+0x38/0x6c
[   80.594943]  el1h_64_irq_handler+0x18/0x24
[   80.594952]  el1h_64_irq+0x68/0x6c
[   80.594958]  arch_cpu_idle+0x1c/0x2c
[   80.594966]  cpuidle_idle_call+0x158/0x1a4
[   80.594977]  do_idle+0x100/0x13c
[   80.594984]  cpu_startup_entry+0x34/0x3c
[   80.594991]  rest_init+0x110/0x190
[   80.595000]  arch_post_acpi_subsys_init+0x0/0x30
[   80.595014]  start_kernel+0x4a4/0x4c0
[   80.595022]  __primary_switched+0xc0/0xc8
[   89.953513] rfkill: input handler enabled
[   93.346510] ISO 9660 Extensions: Microsoft Joliet Level 3
[   93.346710] ISO 9660 Extensions: RRIP_1991A
[   94.359751] rfkill: input handler disabled
[   97.383982] BUG: sleeping function called from invalid context at drivers/misc/vmw_vmci/vmci_guest.c:145
[   97.383987] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 2255, name: vmtoolsd
[   97.383989] preempt_count: 101, expected: 0
[   97.383990] RCU nest depth: 0, expected: 0
[   97.383991] 1 lock held by vmtoolsd/2255:
[   97.383993]  #0: ffff0000874ae440 (sk_lock-AF_VSOCK){+.+.}-{0:0}, at: vsock_connect+0x60/0x330 [vsock]
[   97.384003] Preemption disabled at:
[   97.384004] [<ffff80000151d7d8>] vmci_send_datagram+0x44/0xa0 [vmw_vmci]
[   97.384010] CPU: 0 PID: 2255 Comm: vmtoolsd Tainted: G        W        --------  ---  5.19.0-0.rc8.20220727git39c3c396f813.60.fc37.aarch64 #1
[   97.384012] Hardware name: VMware, Inc. VBSA/VBSA, BIOS VEFI 12/31/2020
[   97.384013] Call trace:
[   97.384014]  dump_backtrace+0xc4/0x130
[   97.384017]  show_stack+0x24/0x80
[   97.384018]  dump_stack_lvl+0x88/0xb4
[   97.384021]  dump_stack+0x18/0x34
[   97.384022]  __might_resched+0x1a0/0x280
[   97.384024]  __might_sleep+0x58/0x90
[   97.384025]  vmci_read_data+0x74/0x120 [vmw_vmci]
[   97.384028]  vmci_dispatch_dgs+0x64/0x204 [vmw_vmci]
[   97.384031]  tasklet_action_common.constprop.0+0x13c/0x150
[   97.384033]  tasklet_action+0x40/0x50
[   97.384034]  __do_softirq+0x23c/0x6b4
[   97.384035]  __irq_exit_rcu+0x104/0x214
[   97.384036]  irq_exit_rcu+0x1c/0x50
[   97.384037]  el1_interrupt+0x38/0x6c
[   97.384039]  el1h_64_irq_handler+0x18/0x24
[   97.384041]  el1h_64_irq+0x68/0x6c
[   97.384042]  preempt_count_sub+0x3c/0xe0
[   97.384043]  _raw_spin_unlock_irqrestore+0x64/0xb0
[   97.384045]  vmci_send_datagram+0x7c/0xa0 [vmw_vmci]
[   97.384048]  vmci_datagram_dispatch+0x84/0x100 [vmw_vmci]
[   97.384051]  vmci_datagram_send+0x2c/0x40 [vmw_vmci]
[   97.384054]  vmci_transport_send_control_pkt+0xb8/0x120 [vmw_vsock_vmci_transport]
[   97.384057]  vmci_transport_connect+0x40/0x7c [vmw_vsock_vmci_transport]
[   97.384058]  vsock_connect+0x278/0x330 [vsock]
[   97.384061]  __sys_connect_file+0x8c/0xc0
[   97.384063]  __sys_connect+0x84/0xb4
[   97.384065]  __arm64_sys_connect+0x2c/0x3c
[   97.384067]  invoke_syscall+0x78/0x100
[   97.384068]  el0_svc_common.constprop.0+0x68/0x124
[   97.384069]  do_el0_svc+0x38/0x4c
[   97.384070]  el0_svc+0x60/0x180
[   97.384071]  el0t_64_sync_handler+0x11c/0x150
[   97.384073]  el0t_64_sync+0x190/0x194
[   98.076186] Xwayland (1118) used greatest stack depth: 8272 bytes left
[  100.111328] BUG: sleeping function called from invalid context at drivers/misc/vmw_vmci/vmci_guest.c:145
[  100.111334] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 2446, name: [pango] FcInit
[  100.111336] preempt_count: 100, expected: 0
[  100.111337] RCU nest depth: 0, expected: 0
[  100.111339] no locks held by [pango] FcInit/2446.
[  100.111340] Preemption disabled at:
[  100.111341] [<ffff800008170318>] __do_softirq+0x98/0x6b4
[  100.111347] CPU: 0 PID: 2446 Comm: [pango] FcInit Tainted: G        W        --------  ---  5.19.0-0.rc8.20220727git39c3c396f813.60.fc37.aarch64 #1
[  100.111350] Hardware name: VMware, Inc. VBSA/VBSA, BIOS VEFI 12/31/2020
[  100.111351] Call trace:
[  100.111352]  dump_backtrace+0xc4/0x130
[  100.111353]  show_stack+0x24/0x80
[  100.111355]  dump_stack_lvl+0x88/0xb4
[  100.111357]  dump_stack+0x18/0x34
[  100.111359]  __might_resched+0x1a0/0x280
[  100.111361]  __might_sleep+0x58/0x90
[  100.111362]  vmci_read_data+0x74/0x120 [vmw_vmci]
[  100.111369]  vmci_dispatch_dgs+0x64/0x204 [vmw_vmci]
[  100.111373]  tasklet_action_common.constprop.0+0x13c/0x150
[  100.111375]  tasklet_action+0x40/0x50
[  100.111376]  __do_softirq+0x23c/0x6b4
[  100.111377]  __irq_exit_rcu+0x104/0x214
[  100.111379]  irq_exit_rcu+0x1c/0x50
[  100.111380]  el0_interrupt+0x84/0x1f0
[  100.111382]  __el0_irq_handler_common+0x18/0x24
[  100.111384]  el0t_64_irq_handler+0x10/0x20
[  100.111385]  el0t_64_irq+0x190/0x194
[  100.139404] input: VMware DnD UInput pointer as /devices/virtual/input/input8
[  101.279218] BUG: sleeping function called from invalid context at drivers/misc/vmw_vmci/vmci_guest.c:145
[  101.279224] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 2194, name: gnome-software
[  101.279227] preempt_count: 102, expected: 0
[  101.279228] RCU nest depth: 0, expected: 0
[  101.279230] 3 locks held by gnome-software/2194:
[  101.279232]  #0: ffff0000b18616f8 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x6c/0x80
[  101.279245]  #1: ffff0000b7aff580 (mapping.invalidate_lock#2){.+.+}-{3:3}, at: page_cache_ra_unbounded+0x74/0x1e0
[  101.279257]  #2: ffff0000ff7721a0 (lock#6){+.+.}-{2:2}, at: folio_add_lru+0x64/0x250
[  101.279265] Preemption disabled at:
[  101.279266] [<ffff80000849e82c>] folio_add_lru+0x6c/0x250
[  101.279269] CPU: 0 PID: 2194 Comm: gnome-software Tainted: G        W        --------  ---  5.19.0-0.rc8.20220727git39c3c396f813.60.fc37.aarch64 #1
[  101.279271] Hardware name: VMware, Inc. VBSA/VBSA, BIOS VEFI 12/31/2020
[  101.279272] Call trace:
[  101.279272]  dump_backtrace+0xc4/0x130
[  101.279275]  show_stack+0x24/0x80
[  101.279276]  dump_stack_lvl+0x88/0xb4
[  101.279278]  dump_stack+0x18/0x34
[  101.279279]  __might_resched+0x1a0/0x280
[  101.279282]  __might_sleep+0x58/0x90
[  101.279284]  vmci_read_data+0x74/0x120 [vmw_vmci]
[  101.279290]  vmci_dispatch_dgs+0x64/0x204 [vmw_vmci]
[  101.279293]  tasklet_action_common.constprop.0+0x13c/0x150
[  101.279295]  tasklet_action+0x40/0x50
[  101.279296]  __do_softirq+0x23c/0x6b4
[  101.279297]  __irq_exit_rcu+0x104/0x214
[  101.279298]  irq_exit_rcu+0x1c/0x50
[  101.279300]  el1_interrupt+0x38/0x6c
[  101.279302]  el1h_64_irq_handler+0x18/0x24
[  101.279304]  el1h_64_irq+0x68/0x6c
[  101.279305]  preempt_count_sub+0x3c/0xe0
[  101.279306]  _raw_spin_unlock_irqrestore+0x64/0xb0
[  101.279308]  __pagevec_lru_add+0xcc/0x180
[  101.279309]  folio_add_lru+0x108/0x250
[  101.279311]  filemap_add_folio+0x98/0xf0
[  101.279312]  add_to_page_cache_lru+0x34/0x80
[  101.279314]  add_ra_bio_pages.isra.0+0x14c/0x340
[  101.279316]  btrfs_submit_compressed_read+0x1dc/0x4cc
[  101.279317]  btrfs_submit_data_bio+0x21c/0x230
[  101.279320]  submit_one_bio+0x5c/0xa0
[  101.279321]  extent_readahead+0x1b4/0x1d0
[  101.279323]  btrfs_readahead+0x1c/0x30
[  101.279324]  read_pages+0x5c/0x3ac
[  101.279326]  page_cache_ra_unbounded+0x12c/0x1e0
[  101.279328]  page_cache_ra_order+0xa0/0x320
[  101.279329]  ondemand_readahead+0x1e8/0x510
[  101.279330]  page_cache_sync_ra+0xa0/0xc0
[  101.279331]  filemap_get_pages+0x17c/0x380
[  101.279332]  filemap_read+0xc4/0x3f0
[  101.279333]  btrfs_file_read_iter+0x74/0x84
[  101.279334]  new_sync_read+0xc4/0x12c
[  101.279335]  vfs_read+0x19c/0x1e4
[  101.279337]  ksys_read+0x68/0xec
[  101.279338]  __arm64_sys_read+0x28/0x34
[  101.279340]  invoke_syscall+0x78/0x100
[  101.279341]  el0_svc_common.constprop.0+0x68/0x124
[  101.279342]  do_el0_svc+0x38/0x4c
[  101.279343]  el0_svc+0x60/0x180
[  101.279345]  el0t_64_sync_handler+0x11c/0x150
[  101.279348]  el0t_64_sync+0x190/0x194
[  106.854631] PK-Backend (2682) used greatest stack depth: 8208 bytes left
[  109.438818] BUG: sleeping function called from invalid context at drivers/misc/vmw_vmci/vmci_guest.c:145
[  109.438824] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1150, name: packagekitd
[  109.438825] preempt_count: 100, expected: 0
[  109.438827] RCU nest depth: 1, expected: 0
[  109.438828] 1 lock held by packagekitd/1150:
[  109.438829]  #0: ffff80000abb0448 (rcu_read_lock){....}-{1:2}, at: filemap_get_read_batch+0x8/0x320
[  109.438840] Preemption disabled at:
[  109.438841] [<ffff800008170318>] __do_softirq+0x98/0x6b4
[  109.438845] CPU: 0 PID: 1150 Comm: packagekitd Tainted: G        W        --------  ---  5.19.0-0.rc8.20220727git39c3c396f813.60.fc37.aarch64 #1
[  109.438847] Hardware name: VMware, Inc. VBSA/VBSA, BIOS VEFI 12/31/2020
[  109.438848] Call trace:
[  109.438849]  dump_backtrace+0xc4/0x130
[  109.438850]  show_stack+0x24/0x80
[  109.438852]  dump_stack_lvl+0x88/0xb4
[  109.438854]  dump_stack+0x18/0x34
[  109.438855]  __might_resched+0x1a0/0x280
[  109.438857]  __might_sleep+0x58/0x90
[  109.438859]  vmci_read_data+0x74/0x120 [vmw_vmci]
[  109.438865]  vmci_dispatch_dgs+0x64/0x204 [vmw_vmci]
[  109.438868]  tasklet_action_common.constprop.0+0x13c/0x150
[  109.438870]  tasklet_action+0x40/0x50
[  109.438871]  __do_softirq+0x23c/0x6b4
[  109.438872]  __irq_exit_rcu+0x104/0x214
[  109.438874]  irq_exit_rcu+0x1c/0x50
[  109.438875]  el1_interrupt+0x38/0x6c
[  109.438877]  el1h_64_irq_handler+0x18/0x24
[  109.438879]  el1h_64_irq+0x68/0x6c
[  109.438880]  lock_acquire.part.0+0x104/0x210
[  109.438882]  lock_acquire+0xa8/0x204
[  109.438884]  filemap_get_read_batch+0x6c/0x320
[  109.438885]  filemap_get_pages+0x80/0x380
[  109.438886]  filemap_read+0xc4/0x3f0
[  109.438887]  btrfs_file_read_iter+0x74/0x84
[  109.438889]  new_sync_read+0xc4/0x12c
[  109.438891]  vfs_read+0x19c/0x1e4
[  109.438892]  ksys_pread64+0x88/0xcc
[  109.438894]  __arm64_sys_pread64+0x2c/0x40
[  109.438895]  invoke_syscall+0x78/0x100
[  109.438896]  el0_svc_common.constprop.0+0x68/0x124
[  109.438897]  do_el0_svc+0x38/0x4c
[  109.438898]  el0_svc+0x60/0x180
[  109.438900]  el0t_64_sync_handler+0x11c/0x150
[  109.438902]  el0t_64_sync+0x190/0x194
[  110.525120] BUG: sleeping function called from invalid context at drivers/misc/vmw_vmci/vmci_guest.c:145
[  110.525136] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper/0
[  110.525140] preempt_count: 101, expected: 0
[  110.525144] RCU nest depth: 0, expected: 0
[  110.525148] no locks held by swapper/0/0.
[  110.525151] Preemption disabled at:
[  110.525154] [<ffff80000932ca40>] schedule_preempt_disabled+0x2c/0x3c
[  110.525175] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W        --------  ---  5.19.0-0.rc8.20220727git39c3c396f813.60.fc37.aarch64 #1
[  110.525181] Hardware name: VMware, Inc. VBSA/VBSA, BIOS VEFI 12/31/2020
[  110.525184] Call trace:
[  110.525186]  dump_backtrace+0xc4/0x130
[  110.525194]  show_stack+0x24/0x80
[  110.525197]  dump_stack_lvl+0x88/0xb4
[  110.525202]  dump_stack+0x18/0x34
[  110.525204]  __might_resched+0x1a0/0x280
[  110.525211]  __might_sleep+0x58/0x90
[  110.525215]  vmci_read_data+0x74/0x120 [vmw_vmci]
[  110.525236]  vmci_dispatch_dgs+0x64/0x204 [vmw_vmci]
[  110.525245]  tasklet_action_common.constprop.0+0x13c/0x150
[  110.525250]  tasklet_action+0x40/0x50
[  110.525254]  __do_softirq+0x23c/0x6b4
[  110.525257]  __irq_exit_rcu+0x104/0x214
[  110.525261]  irq_exit_rcu+0x1c/0x50
[  110.525264]  el1_interrupt+0x38/0x6c
[  110.525270]  el1h_64_irq_handler+0x18/0x24
[  110.525275]  el1h_64_irq+0x68/0x6c
[  110.525278]  default_idle_call+0x50/0xc4
[  110.525283]  cpuidle_idle_call+0x158/0x1a4
[  110.525288]  do_idle+0x100/0x13c
[  110.525292]  cpu_startup_entry+0x34/0x3c
[  110.525296]  rest_init+0x110/0x190
[  110.525301]  arch_post_acpi_subsys_init+0x0/0x30
[  110.525310]  start_kernel+0x4a4/0x4c0
[  110.525314]  __primary_switched+0xc0/0xc8
[  121.284711] BUG: sleeping function called from invalid context at drivers/misc/vmw_vmci/vmci_guest.c:145
[  121.284728] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 762, name: vmtoolsd
[  121.284731] preempt_count: 101, expected: 0
[  121.284734] RCU nest depth: 0, expected: 0
[  121.284737] 1 lock held by vmtoolsd/762:
[  121.284741]  #0: ffff0000874abb00 (sk_lock-AF_VSOCK){+.+.}-{0:0}, at: vsock_connectible_sendmsg+0x5c/0x310 [vsock]
[  121.284774] Preemption disabled at:
[  121.284777] [<ffff80000151d7d8>] vmci_send_datagram+0x44/0xa0 [vmw_vmci]
[  121.284792] CPU: 0 PID: 762 Comm: vmtoolsd Tainted: G        W        --------  ---  5.19.0-0.rc8.20220727git39c3c396f813.60.fc37.aarch64 #1
[  121.284797] Hardware name: VMware, Inc. VBSA/VBSA, BIOS VEFI 12/31/2020
[  121.284799] Call trace:
[  121.284802]  dump_backtrace+0xc4/0x130
[  121.284812]  show_stack+0x24/0x80
[  121.284815]  dump_stack_lvl+0x88/0xb4
[  121.284822]  dump_stack+0x18/0x34
[  121.284824]  __might_resched+0x1a0/0x280
[  121.284831]  __might_sleep+0x58/0x90
[  121.284834]  vmci_read_data+0x74/0x120 [vmw_vmci]
[  121.284840]  vmci_dispatch_dgs+0x64/0x204 [vmw_vmci]
[  121.284856]  tasklet_action_common.constprop.0+0x13c/0x150
[  121.284861]  tasklet_action+0x40/0x50
[  121.284864]  __do_softirq+0x23c/0x6b4
[  121.284867]  __irq_exit_rcu+0x104/0x214
[  121.284869]  irq_exit_rcu+0x1c/0x50
[  121.284872]  el1_interrupt+0x38/0x6c
[  121.284877]  el1h_64_irq_handler+0x18/0x24
[  121.284882]  el1h_64_irq+0x68/0x6c
[  121.284884]  preempt_count_sub+0x0/0xe0
[  121.284887]  vmci_send_datagram+0x7c/0xa0 [vmw_vmci]
[  121.284893]  vmci_datagram_dispatch+0x84/0x100 [vmw_vmci]
[  121.284899]  vmci_datagram_send+0x2c/0x40 [vmw_vmci]
[  121.284906]  vmci_transport_send_control_pkt+0xb8/0x120 [vmw_vsock_vmci_transport]
[  121.284914]  vmci_transport_send_wrote+0x38/0x44 [vmw_vsock_vmci_transport]
[  121.284918]  vmci_transport_notify_pkt_send_post_enqueue+0x7c/0xc0 [vmw_vsock_vmci_transport]
[  121.284922]  vmci_transport_notify_send_post_enqueue+0x28/0x3c [vmw_vsock_vmci_transport]
[  121.284926]  vsock_connectible_sendmsg+0x2b4/0x310 [vsock]
[  121.284931]  sock_sendmsg+0x60/0x70
[  121.284939]  __sys_sendto+0xc4/0x130
[  121.284943]  __arm64_sys_sendto+0x34/0x44
[  121.284946]  invoke_syscall+0x78/0x100
[  121.284950]  el0_svc_common.constprop.0+0x68/0x124
[  121.284952]  do_el0_svc+0x38/0x4c
[  121.284955]  el0_svc+0x60/0x180
[  121.284957]  el0t_64_sync_handler+0x11c/0x150
[  121.284961]  el0t_64_sync+0x190/0x194
[  140.551593] BUG: sleeping function called from invalid context at drivers/misc/vmw_vmci/vmci_guest.c:145
[  140.551609] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper/0
[  140.551613] preempt_count: 101, expected: 0
[  140.551617] RCU nest depth: 0, expected: 0
[  140.551621] no locks held by swapper/0/0.
[  140.551625] Preemption disabled at:
[  140.551628] [<ffff80000932ca40>] schedule_preempt_disabled+0x2c/0x3c
[  140.551649] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W        --------  ---  5.19.0-0.rc8.20220727git39c3c396f813.60.fc37.aarch64 #1
[  140.551654] Hardware name: VMware, Inc. VBSA/VBSA, BIOS VEFI 12/31/2020
[  140.551660] Call trace:
[  140.551663]  dump_backtrace+0xc4/0x130
[  140.551671]  show_stack+0x24/0x80
[  140.551674]  dump_stack_lvl+0x88/0xb4
[  140.551680]  dump_stack+0x18/0x34
[  140.551684]  __might_resched+0x1a0/0x280
[  140.551692]  __might_sleep+0x58/0x90
[  140.551696]  vmci_read_data+0x74/0x120 [vmw_vmci]
[  140.551714]  vmci_dispatch_dgs+0x64/0x204 [vmw_vmci]
[  140.551723]  tasklet_action_common.constprop.0+0x13c/0x150
[  140.551730]  tasklet_action+0x40/0x50
[  140.551733]  __do_softirq+0x23c/0x6b4
[  140.551737]  __irq_exit_rcu+0x104/0x214
[  140.551740]  irq_exit_rcu+0x1c/0x50
[  140.551743]  el1_interrupt+0x38/0x6c
[  140.551750]  el1h_64_irq_handler+0x18/0x24
[  140.551755]  el1h_64_irq+0x68/0x6c
[  140.551759]  arch_cpu_idle+0x1c/0x2c
[  140.551763]  cpuidle_idle_call+0x158/0x1a4
[  140.551771]  do_idle+0x100/0x13c
[  140.551774]  cpu_startup_entry+0x30/0x3c
[  140.551778]  rest_init+0x110/0x190
[  140.551782]  arch_post_acpi_subsys_init+0x0/0x30
[  140.551794]  start_kernel+0x4a4/0x4c0
[  140.551797]  __primary_switched+0xc0/0xc8
[  154.986164] BUG: sleeping function called from invalid context at drivers/misc/vmw_vmci/vmci_guest.c:145
[  154.986171] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 2255, name: vmtoolsd
[  154.986173] preempt_count: 100, expected: 0
[  154.986175] RCU nest depth: 0, expected: 0
[  154.986176] no locks held by vmtoolsd/2255.
[  154.986178] Preemption disabled at:
[  154.986180] [<ffff800008170318>] __do_softirq+0x98/0x6b4
[  154.986186] CPU: 0 PID: 2255 Comm: vmtoolsd Tainted: G        W        --------  ---  5.19.0-0.rc8.20220727git39c3c396f813.60.fc37.aarch64 #1
[  154.986189] Hardware name: VMware, Inc. VBSA/VBSA, BIOS VEFI 12/31/2020
[  154.986190] Call trace:
[  154.986191]  dump_backtrace+0xc4/0x130
[  154.986193]  show_stack+0x24/0x80
[  154.986195]  dump_stack_lvl+0x88/0xb4
[  154.986198]  dump_stack+0x18/0x34
[  154.986199]  __might_resched+0x1a0/0x280
[  154.986202]  __might_sleep+0x58/0x90
[  154.986203]  vmci_read_data+0x74/0x120 [vmw_vmci]
[  154.986212]  vmci_dispatch_dgs+0x64/0x204 [vmw_vmci]
[  154.986216]  tasklet_action_common.constprop.0+0x13c/0x150
[  154.986218]  tasklet_action+0x40/0x50
[  154.986220]  __do_softirq+0x23c/0x6b4
[  154.986221]  __irq_exit_rcu+0x104/0x214
[  154.986223]  irq_exit_rcu+0x1c/0x50
[  154.986224]  el0_interrupt+0x84/0x1f0
[  154.986227]  __el0_irq_handler_common+0x18/0x24
[  154.986229]  el0t_64_irq_handler+0x10/0x20
[  154.986231]  el0t_64_irq+0x190/0x194
[  161.302132] BUG: sleeping function called from invalid context at drivers/misc/vmw_vmci/vmci_guest.c:145
[  161.302146] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper/0
[  161.302150] preempt_count: 101, expected: 0
[  161.302154] RCU nest depth: 0, expected: 0
[  161.302157] no locks held by swapper/0/0.
[  161.302161] Preemption disabled at:
[  161.302164] [<ffff80000932ca40>] schedule_preempt_disabled+0x2c/0x3c
[  161.302183] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W        --------  ---  5.19.0-0.rc8.20220727git39c3c396f813.60.fc37.aarch64 #1
[  161.302188] Hardware name: VMware, Inc. VBSA/VBSA, BIOS VEFI 12/31/2020
[  161.302191] Call trace:
[  161.302193]  dump_backtrace+0xc4/0x130
[  161.302200]  show_stack+0x24/0x80
[  161.302204]  dump_stack_lvl+0x88/0xb4
[  161.302208]  dump_stack+0x18/0x34
[  161.302211]  __might_resched+0x1a0/0x280
[  161.302217]  __might_sleep+0x58/0x90
[  161.302221]  vmci_read_data+0x74/0x120 [vmw_vmci]
[  161.302240]  vmci_dispatch_dgs+0x64/0x204 [vmw_vmci]
[  161.302248]  tasklet_action_common.constprop.0+0x13c/0x150
[  161.302254]  tasklet_action+0x40/0x50
[  161.302257]  __do_softirq+0x23c/0x6b4
[  161.302260]  __irq_exit_rcu+0x104/0x214
[  161.302264]  irq_exit_rcu+0x1c/0x50
[  161.302267]  el1_interrupt+0x38/0x6c
[  161.302272]  el1h_64_irq_handler+0x18/0x24
[  161.302277]  el1h_64_irq+0x68/0x6c
[  161.302280]  default_idle_call+0x50/0xc4
[  161.302285]  cpuidle_idle_call+0x158/0x1a4
[  161.302291]  do_idle+0x100/0x13c
[  161.302294]  cpu_startup_entry+0x30/0x3c
[  161.302299]  rest_init+0x110/0x190
[  161.302304]  arch_post_acpi_subsys_init+0x0/0x30
[  161.302312]  start_kernel+0x4a4/0x4c0
[  161.302316]  __primary_switched+0xc0/0xc8
[  170.517400] BUG: sleeping function called from invalid context at drivers/misc/vmw_vmci/vmci_guest.c:145
[  170.517416] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 762, name: vmtoolsd
[  170.517420] preempt_count: 101, expected: 0
[  170.517423] RCU nest depth: 0, expected: 0
[  170.517428] 1 lock held by vmtoolsd/762:
[  170.517431]  #0: ffff0000874abb00 (sk_lock-AF_VSOCK){+.+.}-{0:0}, at: vsock_connectible_sendmsg+0x5c/0x310 [vsock]
[  170.517465] Preemption disabled at:
[  170.517468] [<ffff80000151d7d8>] vmci_send_datagram+0x44/0xa0 [vmw_vmci]
[  170.517484] CPU: 0 PID: 762 Comm: vmtoolsd Tainted: G        W        --------  ---  5.19.0-0.rc8.20220727git39c3c396f813.60.fc37.aarch64 #1
[  170.517489] Hardware name: VMware, Inc. VBSA/VBSA, BIOS VEFI 12/31/2020
[  170.517491] Call trace:
[  170.517493]  dump_backtrace+0xc4/0x130
[  170.517503]  show_stack+0x24/0x80
[  170.517506]  dump_stack_lvl+0x88/0xb4
[  170.517517]  dump_stack+0x18/0x34
[  170.517520]  __might_resched+0x1a0/0x280
[  170.517528]  __might_sleep+0x58/0x90
[  170.517531]  vmci_read_data+0x74/0x120 [vmw_vmci]
[  170.517538]  vmci_dispatch_dgs+0x64/0x204 [vmw_vmci]
[  170.517544]  tasklet_action_common.constprop.0+0x13c/0x150
[  170.517550]  tasklet_action+0x40/0x50
[  170.517553]  __do_softirq+0x23c/0x6b4
[  170.517555]  __irq_exit_rcu+0x104/0x214
[  170.517558]  irq_exit_rcu+0x1c/0x50
[  170.517561]  el1_interrupt+0x38/0x6c
[  170.517567]  el1h_64_irq_handler+0x18/0x24
[  170.517572]  el1h_64_irq+0x68/0x6c
[  170.517574]  preempt_count_sub+0x1c/0xe0
[  170.517577]  vmci_send_datagram+0x7c/0xa0 [vmw_vmci]
[  170.517584]  vmci_datagram_dispatch+0x84/0x100 [vmw_vmci]
[  170.517591]  vmci_datagram_send+0x2c/0x40 [vmw_vmci]
[  170.517597]  vmci_transport_send_control_pkt+0xb8/0x120 [vmw_vsock_vmci_transport]
[  170.517606]  vmci_transport_send_wrote+0x38/0x44 [vmw_vsock_vmci_transport]
[  170.517610]  vmci_transport_notify_pkt_send_post_enqueue+0x7c/0xc0 [vmw_vsock_vmci_transport]
[  170.517614]  vmci_transport_notify_send_post_enqueue+0x28/0x3c [vmw_vsock_vmci_transport]
[  170.517618]  vsock_connectible_sendmsg+0x2b4/0x310 [vsock]
[  170.517623]  sock_sendmsg+0x60/0x70
[  170.517630]  __sys_sendto+0xc4/0x130
[  170.517634]  __arm64_sys_sendto+0x34/0x44
[  170.517637]  invoke_syscall+0x78/0x100
[  170.517641]  el0_svc_common.constprop.0+0x68/0x124
[  170.517644]  do_el0_svc+0x38/0x4c
[  170.517647]  el0_svc+0x60/0x180
[  170.517650]  el0t_64_sync_handler+0x11c/0x150
[  170.517653]  el0t_64_sync+0x190/0x194
[  181.304276] BUG: sleeping function called from invalid context at drivers/misc/vmw_vmci/vmci_guest.c:145
[  181.304290] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper/0
[  181.304294] preempt_count: 101, expected: 0
[  181.304298] RCU nest depth: 0, expected: 0
[  181.304301] no locks held by swapper/0/0.
[  181.304305] Preemption disabled at:
[  181.304308] [<ffff80000932ca40>] schedule_preempt_disabled+0x2c/0x3c
[  181.304328] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W        --------  ---  5.19.0-0.rc8.20220727git39c3c396f813.60.fc37.aarch64 #1
[  181.304334] Hardware name: VMware, Inc. VBSA/VBSA, BIOS VEFI 12/31/2020
[  181.304337] Call trace:
[  181.304339]  dump_backtrace+0xc4/0x130
[  181.304346]  show_stack+0x24/0x80
[  181.304349]  dump_stack_lvl+0x88/0xb4
[  181.304354]  dump_stack+0x18/0x34
[  181.304357]  __might_resched+0x1a0/0x280
[  181.304363]  __might_sleep+0x58/0x90
[  181.304367]  vmci_read_data+0x74/0x120 [vmw_vmci]
[  181.304386]  vmci_dispatch_dgs+0x64/0x204 [vmw_vmci]
[  181.304394]  tasklet_action_common.constprop.0+0x13c/0x150
[  181.304399]  tasklet_action+0x40/0x50
[  181.304403]  __do_softirq+0x23c/0x6b4
[  181.304405]  __irq_exit_rcu+0x104/0x214
[  181.304409]  irq_exit_rcu+0x1c/0x50
[  181.304413]  el1_interrupt+0x38/0x6c
[  181.304418]  el1h_64_irq_handler+0x18/0x24
[  181.304423]  el1h_64_irq+0x68/0x6c
[  181.304426]  default_idle_call+0x50/0xc4
[  181.304431]  cpuidle_idle_call+0x158/0x1a4
[  181.304437]  do_idle+0x100/0x13c
[  181.304441]  cpu_startup_entry+0x30/0x3c
[  181.304445]  rest_init+0x110/0x190
[  181.304450]  arch_post_acpi_subsys_init+0x0/0x30
[  181.304458]  start_kernel+0x4a4/0x4c0
[  181.304462]  __primary_switched+0xc0/0xc8

--dXZvnDVhCxPQHnjO--
