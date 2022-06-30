Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F76562768
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 01:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbiF3XvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 19:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbiF3Xu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 19:50:56 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71685192B3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 16:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656633049; x=1688169049;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=gh5eXvBo2qn3Chr+j2uyqeoqtYAocirA5I+MoANqEdo=;
  b=RDxLpVmhDLYWhOWg9yW4pNO+HMozoJULURThNVUjfX2o4GJIZQ4kjXcG
   +yJ0laMuGuovMGj8EY7ZL76BBTcyWeSxkD5kfaFoTzcsIksvhaWX8TDfB
   3g9CmBdrdI5hXD9bOq6nQnK0Jargdg2qMKstiBJNTaiuR6rsiU7YUAeAj
   tF54B1483dZrCCLPQpjR0SYp2BtNRa/55U3Xd0l2rjOwbSpitPt92DH01
   yFkgX/zWBEyENRR33TH6AfUWodmwBZlZb6PlvUZM2DMpIUN/NNLyOPttQ
   Uj3MR7edHgxhTWDonDrWdSgKkeOOP9a68AIW9tHXGRirhCXh3VX+7yqSV
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="281264368"
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="281264368"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 16:50:48 -0700
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="733830223"
Received: from jkerpeld-mobl.amr.corp.intel.com (HELO [10.255.228.66]) ([10.255.228.66])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 16:50:48 -0700
Message-ID: <ca73d2bd-5d40-d385-aeb0-8c04811690ff@linux.intel.com>
Date:   Thu, 30 Jun 2022 16:50:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v8 1/5] x86/tdx: Add TDX Guest attestation interface
 driver
To:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220609025220.2615197-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <0f6bedbb-14cc-bf93-5d9f-bfd2c49dc7b2@intel.com>
 <48b9d807-2d9e-016f-bada-906911d6ecb0@linux.intel.com>
 <f26f88ee-1226-3e32-77cc-fc86bc65e0b7@intel.com>
Content-Language: en-US
In-Reply-To: <f26f88ee-1226-3e32-77cc-fc86bc65e0b7@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/27/22 10:24 AM, Dave Hansen wrote:
> On 6/27/22 07:50, Sathyanarayanan Kuppuswamy wrote:

>>> Second, how can someone test this code?  It appears that they need to
>>> assemble a veritable Rube Goldberg machine.  The least we could do is
>>> have a selftest that just calls the ioctl() and makes sure that
>>> something halfway sane comes out of it.
>>
>> My initial submission included a test app. But I removed it later to
>> reduce the review load. I thought to submit the test app once feature
>> support patches are merged.
>>
>> https://lore.kernel.org/all/9247fade9db5ae6eb183b2f92fdedb898282376a.1648664666.git.sathyanarayanan.kuppuswamy@intel.com/
>>
>> If you prefer, I can add it back to the next submission with the latest changes.
> 
> I doubt anyone will ever run a "test app".  Why not just make this a
> selftest?

Fine with me. I can change it into selftest.

> 
>>>> In such
>>>> case, since REPORTDATA is a secret, using sysfs to share it is insecure
>>>> compared to sending it via IOCTL.
>>>
>>> Huh?  How is sysfs "insecure"?
>>
>> REPORTDATA (input) we pass to the Module call might come from attestation
>> service as a per session unique ID.  If it is shared via sysfs, there is
>> a possibility for untrusted software to read it and trigger some form of
>> reply attack. So in this context, sysfs is insecure compared to IOCTL
>> approach. You can find the related discussion in,
>>
>> https://lore.kernel.org/lkml/b8eadd3079101a2cf93ee87d36dbedf93d8a2725.camel@intel.com/
> 
> I still don't get it.
> 
> How is a 400 sysfs file "insecure"?  This sounds "if the filesystem
> permissions are broken" paranoia.  In other words, you're protecting
> against a malicious root user.

AFAIK, root is not the only user of the attestation interface. General users can
also use it (For example, in a use case like pytorch, attestation may be requested
by server before passing the training data). So if the permission is not "root
only", then other users or application in TD can access the sysfs file to read
its contents. 

Also, the security concern mentioned is just an additional point. Following are
the main reasons for choosing IOCTL over sysfs.

1. Sysfs is generally used for config purposes. Not for request/response kind of
   use case (Attestation falls under this category).
2. If we only use sysfs model for GetReport, the design might look like below: 

    /sys/kernel/../report/input
    /sys/kernel/../report/subtype
    /sys/kernel/../report/input_len
    /sys/kernel/../report/output
    /sys/kernel/../report/output_len
    /sys/kernel/../report/status
    /sys/kernel/../report/trigger

We might need similar files for GetQuote use case as well. IMO, such a design is 
more complicated than using IOCTL.

> 
> In other words, I don't think the ABI here has been well thought out.
> 
> Also, this is basically a:
> 
> 	Inputs:
> 
> 		* nonce
> 		* report type
> 
> 	Outputs:
> 
> 		* report
> 
> I have to wonder how hard it would be to have this be:
> 
> 	fd = open("/dev/foo");
> 	ioctl(fd, REPORT, type, flags??);
> 	write(fd, &inputs, inputs_len);
> 	read(fd,  &output, outputs_len);
> 

It is not hard to implement it this way. But I don't see it being
very different from just using IOCTL. config/{read/write} model is
usually preferred for applications in which you have a requirement to do
multiple read/writes after one time config (use cases like serial
port read, printer write or reading temperature, etc). But in our case
we will mostly use it once after every config. 

Also, splitting input over IOCTL and write system call will require us
to add additional code to store the state.

I have attempted a sample implementation (untested) for reference. But I
feel our current code is simpler. It handles allocation and input/output
validation in one place compared to spreading it across multiple handlers. 

struct report_req {
        int subtype;
        void *reportdata;
        int reportdata_len;
};

struct tdx_attest_req {
        unsigned int cmd;
        void *data;
};


static long tdx_attest_ioctl(struct file *file, unsigned int cmd,
                             unsigned long arg)
{
        void __user *argp = (void __user *)arg;
        struct tdx_attest_req *areq = file->private_data;
        struct report_req *rep_data = NULL;
        struct tdx_report_req user_req;
        long ret = -EINVAL;

        switch (cmd) {
        case TDX_CMD_GET_REPORT:
                /* Allocate space for TDREPORT request */
                rep_data = kmalloc(sizeof(struct report_req), GFP_KERNEL);
                if (!rep_data)
                        return -ENOMEM;

                /* Copy user request data */
                if (copy_from_user(&user_req, argp, sizeof(user_req))) {
                        kfree(rep_data);
                        return -EFAULT;
                }

                /* Copy user request details to areq->data */
                rep_data->subtype = user_req.subtype;
                areq->cmd = cmd;
                areq->data = rep_data;

                ret = 0;
                break;
        default:
                pr_debug("cmd %d not supported\n", cmd);
                break;
        }

        return ret;
}

static ssize_t tdx_attest_read(struct file *filp, char __user *buffer,
                                size_t length, loff_t *offset)
{
        struct tdx_attest_req *areq = filp->private_data;
        struct report_req *rep_data;
        void *tdreport;
        long ret;

        if (!areq)
                return -EINVAL;

        switch (areq->cmd) {
        case TDX_CMD_GET_REPORT:

                /* Check for valid length and offset */
                if (length != TDX_REPORT_LEN || offset != 0)
                        return -EINVAL;

                rep_data = areq->data;

                /* Make sure we have valid reportdata */
                if (!rep_data->reportdata)
                        return -EINVAL;

                /* Allocate space for output data */
                tdreport = kzalloc(length, GFP_KERNEL);
                if (!tdreport)
                        return -ENOMEM;
                /*
                 * Generate TDREPORT using "TDG.MR.REPORT" TDCALL.
                 *
                 * Get the TDREPORT using REPORTDATA as input. Refer to
                 * section 22.3.3 TDG.MR.REPORT leaf in the TDX Module 1.0
                 * Specification for detailed information.
                 */
                ret = __tdx_module_call(TDX_GET_REPORT, virt_to_phys(tdreport),
                                virt_to_phys(rep_data->reportdata), 0, 0, NULL);
                if (ret) {
                        pr_debug("TDREPORT TDCALL failed, status:%lx\n", ret);
                       kfree(tdreport);
                        return -EIO;
                }

                /* Copy REPORTDATA from the user buffer */
                if (copy_to_user(buffer, tdreport, length)) {
                        kfree(tdreport);
                        return -EFAULT;
                }

                return length;
        default:
                pr_debug("cmd %d not supported\n", areq->cmd);
                break;
        }

        return 0;
}

static ssize_t tdx_attest_write(struct file *filp, const char __user *buffer,
                                size_t length, loff_t *offset)
{
        struct tdx_attest_req *areq = filp->private_data;
        struct report_req *rep_data;

        if (!areq)
                return -EINVAL;

        switch (areq->cmd) {
        case TDX_CMD_GET_REPORT:

                /* Check for valid length and offset */
                if (length != TDX_REPORTDATA_LEN || offset != 0)
                        return -EINVAL;

                rep_data = areq->data;

                /* Allocate space to store REPORTDATA */
                rep_data->reportdata = kzalloc(length, GFP_KERNEL);
                if (!rep_data->reportdata)
                        return -ENOMEM;

                /* Copy REPORTDATA from the user buffer */
                if (copy_from_user(rep_data->reportdata, buffer, length)) {
                        kfree(rep_data->reportdata);
                        rep_data->reportdata = NULL;
                        return -EFAULT;
                }

                rep_data->reportdata_len = length;

                return length;
        default:
                pr_debug("cmd %d not supported\n", areq->cmd);
                break;
        }

        return 0;
}


static int tdx_attest_open(struct inode *inode, struct file *filp)
{
        struct tdx_attest_req *areq;

        /* Allocate space to track attestation request */
        areq = kmalloc(sizeof(*areq), GFP_KERNEL);
        if (!areq)
                return -ENOMEM;

        filp->private_data = areq;

        return 0;
}

static int tdx_attest_release(struct inode *inode, struct file *filp)
{
        kfree(filp->private_data);
        filp->private_data = NULL;

        return 0;
}

static const struct file_operations tdx_attest_fops = {
        .owner          = THIS_MODULE,
        .open           = tdx_attest_open,
        .read           = tdx_attest_read,
        .write          = tdx_attest_write,
        .unlocked_ioctl = tdx_attest_ioctl,
        .release        = tdx_attest_release,
        .llseek         = no_llseek,
};

>>> How many of these "drivers" are we going to need which are thinly veiled
>>> ioctl()s that are only TDX module call wrappers?
> 
> This is actually a really big question.  This code is obviously just
> trying to do one thing very narrowly and not thinking about the future
> at all.  Can we please consider what the future will be like and try to
> *architect* this instead of having the kernel just play a glorified game
> of telephone?

I am not very clear about other possible use cases. 

Kirill/Kai/Isaku, Do you think we might need similar infrastructure for any
other TDX Module calls or TDVMCALLs?


-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
