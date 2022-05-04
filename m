Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9216C51B247
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 00:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbiEDWyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 18:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379199AbiEDWxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:53:35 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBA753A6B
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651704586; x=1683240586;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1I1uUi95Cz51INKe7NaSWIiJ2vBXGDENvbgzS2w31To=;
  b=msxs/d981I1BR824HT2ZrFCGhJWRPII3rKVkW4gR9/sTaF31BPdBPYc1
   Wv1WhsdC8UTeze9MJD5RWlURhRaxFCYCMnGSgl3tbm8BZ8eQ1aGbWvwuA
   Qv/yBMJi3HLAt8f4dosoXLeHgT17eQA/DpQet3qTRbXm31LS503atlC7N
   N2gIq5iXVIijkyTXrrHvvHj0XAAhmjDkiRFYSceF5zOTBVy8MAFCGlkvE
   Em6KM1RdXm/WjtoEyuEHTquGkuCmWdr1jbokmVDC2bHxqZwQrjLcN+/me
   3uzFbryXznMpk8ZFxpZPG+/kP85yePpDhIj9V+yJqg+IcNBWLxyUSGh/+
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="267514915"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="267514915"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 15:49:45 -0700
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="517233710"
Received: from rfrenner-mobl1.amr.corp.intel.com (HELO [10.209.45.158]) ([10.209.45.158])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 15:49:45 -0700
Message-ID: <40ccd0f0-35a1-5aa7-9e51-25ab196d79e5@linux.intel.com>
Date:   Wed, 4 May 2022 15:49:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v5 3/3] x86/tdx: Add Quote generation support
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Kai Huang <kai.huang@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
References: <20220501183500.2242828-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220501183500.2242828-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <243e918c523320ba3d216cbe22d24fe5ce33f370.camel@intel.com>
 <20220503012721.ok7fbvxmnvsr6qny@box.shutemov.name>
 <58d07b2d-cef5-17ed-9c57-e12fe5665e04@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <58d07b2d-cef5-17ed-9c57-e12fe5665e04@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/3/22 3:24 PM, Dave Hansen wrote:
> On 5/2/22 18:27, Kirill A. Shutemov wrote:
>>> Again, Dave and Andi already commented you should use vmap() to avoid breaking
>>> up the direct-mapping.  Please use vmap() instead.
>>>
>>> https://lore.kernel.org/all/ce0feeec-a949-35f8-3010-b0d69acbbc2e@linux.intel.com/
>>>
>>> Will review the rest later.
>> I would rather convert it to use DMA API for memory allocation. It will
>> tap into swiotlb buffer that already converted and there's no need to
>> touch direct mapping. Both allocation and freeing such memory is cheaper
>> because of that.
> 
> Sathya, I don't quite understand why you are so forcefully declining to
> incorporate review feedback on this point.  I gave very specific
> feedback about the kind of mapping you need and that you should avoid
> fragmenting the direct map if at all possible.
> 
> Why is this code still fragmenting the direct map?

Next version will looks like below. It includes vmap support. It also
supports parallel GetQuote reuests by using list to track active
GetQuote request list. Did some inital test. It seems to work fine.

Please take a look at it and let me know your comments.

I will continue to test more cases in parallel.

diff --git a/arch/x86/coco/tdx/attest.c b/arch/x86/coco/tdx/attest.c
index 81b59d060392..0ed959dacb7e 100644
--- a/arch/x86/coco/tdx/attest.c
+++ b/arch/x86/coco/tdx/attest.c
@@ -13,20 +13,44 @@
  #include <linux/miscdevice.h>
  #include <linux/mm.h>
  #include <linux/io.h>
+#include <linux/set_memory.h>
+#include <linux/spinlock.h>
  #include <asm/tdx.h>
+#include <asm/coco.h>
  #include <uapi/asm/tdx.h>

  #define DRIVER_NAME "tdx-attest"

  /* TDREPORT module call leaf ID */
  #define TDX_GET_REPORT                 4
+/* GetQuote hypercall leaf ID */
+#define TDVMCALL_GET_QUOTE             0x10002

  /* Upper 32 bits has the status code, so mask it */
  #define TDCALL_STATUS_CODE_MASK                0xffffffff00000000
  #define TDCALL_STATUS_CODE(a)          ((a) & TDCALL_STATUS_CODE_MASK)

+/* Used for buffer allocation in GetQuote request */
+struct quote_buf {
+       struct page **pages;
+       int count;
+       void *vmaddr;
+};
+
+/* List entry of quote_list*/
+struct quote_entry {
+       struct quote_buf *buf;
+       struct completion compl;
+       struct list_head list;
+};
+
  static struct miscdevice miscdev;

+/* List to track active GetQuote requests */
+static LIST_HEAD(quote_list);
+/* Lock to protect quote_list */
+static DEFINE_SPINLOCK(quote_lock);
+
  static long tdx_get_report(void __user *argp)
  {
         void *reportdata = NULL, *tdreport = NULL;
@@ -76,6 +100,214 @@ static long tdx_get_report(void __user *argp)
         return ret;
  }

+/* tdx_get_quote_hypercall() - Request to get TD Quote using TDREPORT */
+static long tdx_get_quote_hypercall(struct quote_buf *buf)
+{
+       struct tdx_hypercall_args args = {0};
+
+       args.r10 = TDX_HYPERCALL_STANDARD;
+       args.r11 = TDVMCALL_GET_QUOTE;
+       args.r12 = cc_mkdec(page_to_phys(vmalloc_to_page(buf->vmaddr)));
+       args.r13 = buf->count * PAGE_SIZE;
+
+       /*
+        * Pass the physical address of TDREPORT to the VMM and
+        * trigger the Quote generation. It is not a blocking
+        * call, hence completion of this request will be notified to
+        * the TD guest via a callback interrupt. More info about ABI
+        * can be found in TDX Guest-Host-Communication Interface
+        * (GHCI), sec titled "TDG.VP.VMCALL<GetQuote>".
+        */
+       return __tdx_hypercall(&args, 0);
+}
+
+static struct quote_buf *alloc_quote_buf(u64 req_size)
+{
+       int size = PAGE_ALIGN(req_size);
+       void *addr = NULL, *vmaddr = NULL;
+       int count = size >> PAGE_SHIFT;
+       struct quote_buf *buf;
+       struct page **pages;
+       int i;
+
+       buf = kmalloc(sizeof(*buf), GFP_KERNEL);
+       if (!buf)
+               return NULL;
+
+       /* Allocate mem for array of page ptrs */
+       pages = kcalloc(count, sizeof(*pages), GFP_KERNEL);
+       if (!pages)
+               goto alloc_failed;
+
+       addr = alloc_pages_exact(size, GFP_KERNEL);
+       if (!addr)
+               goto alloc_failed;
+
+       for (i = 0; i < count; i++)
+               pages[i] = virt_to_page(addr + i * PAGE_SIZE);
+
+       vmaddr = vmap(pages, count, VM_MAP, PAGE_KERNEL);
+       if (!vmaddr)
+               goto alloc_failed;
+
+       /* Mark the memory shared to allow VMM access it */
+       if (set_memory_decrypted((unsigned long)vmaddr, count))
+               goto alloc_failed;
+
+       buf->pages = pages;
+       buf->count = count;
+       buf->vmaddr = vmaddr;
+
+       return buf;
+
+alloc_failed:
+       if (vmaddr)
+               vunmap(vmaddr);
+       if (addr)
+               free_pages_exact(addr, size);
+       kfree(pages);
+       kfree(buf);
+       return NULL;
+}
+
+static void free_quote_buf(struct quote_buf *buf)
+{
+       if (!buf)
+               return;
+
+       /* Mark pages private */
+       if (set_memory_encrypted((unsigned long)buf->vmaddr, buf->count)) {
+               pr_warn("Failed to encrypt %d pages at %p", buf->count,
+                               buf->vmaddr);
+               return;
+       }
+
+       vunmap(buf->vmaddr);
+
+       while (buf->count--)
+               __free_page(buf->pages[buf->count]);
+
+       kfree(buf->pages);
+       kfree(buf);
+}
+
+static struct quote_entry *alloc_quote_entry(struct tdx_quote_req 
*quote_req)
+{
+       struct quote_entry *entry = NULL;
+
+       entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+       if (!entry)
+               return NULL;
+
+       /* Allocate buffer for quote request */
+       entry->buf = alloc_quote_buf(quote_req->len);
+       if (entry->buf) {
+               kfree(entry);
+               return NULL;
+       }
+
+       init_completion(&entry->compl);
+
+       return entry;
+}
+
+static void free_quote_entry(struct quote_entry *entry)
+{
+       free_quote_buf(entry->buf);
+       kfree(entry);
+}
+
+void add_quote_entry(struct quote_entry *entry)
+{
+       unsigned long flags;
+
+       spin_lock_irqsave(&quote_lock, flags);
+       list_add_tail(&entry->list, &quote_list);
+       spin_unlock_irqrestore(&quote_lock, flags);
+}
+
+void del_quote_entry(struct quote_entry *entry)
+{
+       unsigned long flags;
+
+       spin_lock_irqsave(&quote_lock, flags);
+       list_del(&entry->list);
+       spin_unlock_irqrestore(&quote_lock, flags);
+}
+
+static long tdx_get_quote(void __user *argp)
+{
+       struct tdx_quote_req quote_req;
+       struct quote_entry *entry;
+       struct quote_buf *buf;
+       long ret = 0;
+
+       /* Copy GetQuote request struct from user buffer */
+       if (copy_from_user(&quote_req, argp, sizeof(struct tdx_quote_req)))
+               return -EFAULT;
+
+       /* Make sure the length is valid */
+       if (!quote_req.len)
+               return -EINVAL;
+
+       entry = alloc_quote_entry(&quote_req);
+       if (!entry)
+               return -ENOMEM;
+
+       buf = entry->buf;
+
+       /* Copy TDREPORT from user buffer to kernel Quote buffer */
+       if (copy_from_user(buf->vmaddr, (void __user *)quote_req.buf,
+                               quote_req.len)) {
+               ret = -EFAULT;
+               goto free_entry;
+       }
+
+       /* Submit GetQuote Request */
+       ret = tdx_get_quote_hypercall(buf);
+       if (ret) {
+               pr_err("GetQuote hypercall failed, status:%lx\n", ret);
+               ret = -EIO;
+               goto free_entry;
+       }
+
+       /* Add current quote entry to quote_list */
+       add_quote_entry(entry);
+
+       /* Wait for attestation completion */
+       ret = wait_for_completion_interruptible(&entry->compl);
+       if (ret < 0) {
+               ret = -EIO;
+               goto del_entry;
+       }
+
+       /* Copy output data back to user buffer */
+       if (copy_to_user((void __user *)quote_req.buf, buf->vmaddr, 
quote_req.len))
+               ret = -EFAULT;
+
+del_entry:
+       del_quote_entry(entry);
+free_entry:
+       free_quote_entry(entry);
+       return ret;
+}
+
+static void attestation_callback_handler(void)
+{
+       struct tdx_quote_hdr *quote_hdr;
+       struct quote_entry *entry;
+
+       /* Find processed quote request and mark it complete */
+       spin_lock(&quote_lock);
+       list_for_each_entry(entry, &quote_list, list) {
+               quote_hdr = (struct tdx_quote_hdr *)entry->buf->vmaddr;
+               /* If status is either success or failure, mark it 
complete */
+               if (quote_hdr->status != GET_QUOTE_IN_FLIGHT)
+                       complete(&entry->compl);
+       }
+       spin_unlock(&quote_lock);
+}
+
  static long tdx_attest_ioctl(struct file *file, unsigned int cmd,
                              unsigned long arg)
  {
@@ -86,6 +318,9 @@ static long tdx_attest_ioctl(struct file *file, 
unsigned int cmd,
         case TDX_CMD_GET_REPORT:
                 ret = tdx_get_report(argp);
                 break;
+       case TDX_CMD_GET_QUOTE:
+               ret = tdx_get_quote(argp);
+               break;
         default:
                 pr_debug("cmd %d not supported\n", cmd);
                 break;
@@ -108,6 +343,9 @@ static int __init tdx_attestation_init(void)
         if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
                 return -EIO;

+       /* Register attestation event notify handler */
+       tdx_setup_ev_notify_handler(attestation_callback_handler);
+
         miscdev.name = DRIVER_NAME;
         miscdev.minor = MISC_DYNAMIC_MINOR;
         miscdev.fops = &tdx_attest_fops;
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index b49211994864..ab6c94cd880d 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -15,6 +15,7 @@
  #include <asm/idtentry.h>
  #include <asm/irq_regs.h>
  #include <asm/desc.h>
+#include <asm/io.h>

  /* TDX module Call Leaf IDs */
  #define TDX_GET_INFO                   1
@@ -680,8 +681,15 @@ static bool try_accept_one(phys_addr_t *start, 
unsigned long len,
   */
  static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, 
bool enc)
  {
-       phys_addr_t start = __pa(vaddr);
-       phys_addr_t end   = __pa(vaddr + numpages * PAGE_SIZE);
+       phys_addr_t start;
+       phys_addr_t end;
+
+       if (is_vmalloc_addr((void *)vaddr))
+               start =  page_to_phys(vmalloc_to_page((void*)vaddr));
+       else
+               start = __pa(vaddr);
+
+       end = start + numpages * PAGE_SIZE;

         if (!enc) {
                 /* Set the shared (decrypted) bits: */
diff --git a/arch/x86/include/uapi/asm/tdx.h 
b/arch/x86/include/uapi/asm/tdx.h
index 5b721e0ebbb8..3fb69fe3ffb7 100644
--- a/arch/x86/include/uapi/asm/tdx.h
+++ b/arch/x86/include/uapi/asm/tdx.h
@@ -33,4 +33,43 @@ struct tdx_report_req {
  /* Get TDREPORT using TDCALL[TDG.MR.REPORT) */
  #define TDX_CMD_GET_REPORT             _IOWR('T', 0x01, struct 
tdx_report_req)

+/* struct tdx_quote_req: Request to generate TD Quote using TDREPORT
+ *
+ * @buf                : Pass user data that includes TDREPORT as 
input. Upon
+ *               successful completion of IOCTL, output is copied
+ *               back to the same buffer.
+ * @len                : Length of the buffer.
+ */
+struct tdx_quote_req {
+       __u64 buf;
+       __u64 len;
+};
+
+/* Get TD Quote from QE/QGS using GetQuote TDVMCALL */
+#define TDX_CMD_GET_QUOTE              _IOR('T', 0x02, struct 
tdx_quote_req)
+
+/* TD Quote status codes */
+#define GET_QUOTE_SUCCESS              0
+#define GET_QUOTE_IN_FLIGHT            0xffffffffffffffff
+#define GET_QUOTE_ERROR                        0x8000000000000000
+#define GET_QUOTE_SERVICE_UNAVAILABLE  0x8000000000000001
+
+/*
+ * Format of Quote data header. More details can be found in TDX
+ * Guest-Host Communication Interface (GHCI) for Intel TDX 1.0,
+ * section titled "TDG.VP.VMCALL<GetQuote>"
+ */
+struct tdx_quote_hdr {
+       /* Quote version, filled by TD */
+       __u64 version;
+       /* Status code of Quote request, filled by VMM */
+       __u64 status;
+       /* Length of TDREPORT, filled by TD */
+       __u32 in_len;
+       /* Length of Quote, filled by VMM */
+       __u32 out_len;
+       /* Actual Quote data */
+       __u64 data[0];
+};
+
  #endif /* _UAPI_ASM_X86_TDX_H */


-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
