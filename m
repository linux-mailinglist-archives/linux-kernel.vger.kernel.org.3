Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA81C5119C5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236921AbiD0OC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236807AbiD0OCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:02:19 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AF04738F;
        Wed, 27 Apr 2022 06:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651067919; x=1682603919;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=cQkL9trQUR2+NQzgjdaYFGiSEDlNIUcLL65oyUxQarg=;
  b=klOP8OWwbSYSkTt75BegfHoYXzjI797kNT7WT6DrK3nZ6wDTc8v4dQcS
   5bBGOr0RLZGetdbGuo/Y0NmD69QzsyM21qswclBQSbfPszJEgKea0v38r
   1SXE/nWPuOY2t+nZOcO4dEQQuErCh4kFia3S1p7nqTsSkReSyPRDywfD9
   o=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 27 Apr 2022 06:58:28 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 06:58:27 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 27 Apr 2022 06:58:26 -0700
Received: from qian (10.80.80.8) by nalasex01a.na.qualcomm.com (10.47.209.196)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 27 Apr
 2022 06:58:25 -0700
Date:   Wed, 27 Apr 2022 09:58:23 -0400
From:   Qian Cai <quic_qiancai@quicinc.com>
To:     =?iso-8859-1?Q?Thi=E9baud?= Weksteen <tweek@google.com>
CC:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Alistair Delva <adelva@google.com>,
        Adam Shih <adamshih@google.com>, <selinux@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] firmware_loader: use kernel credentials when reading
 firmware
Message-ID: <20220427135823.GD71@qian>
References: <20220422013215.2301793-1-tweek@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220422013215.2301793-1-tweek@google.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 11:32:15AM +1000, Thiébaud Weksteen wrote:
>  drivers/base/firmware_loader/main.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> index 94d1789a233e..8f3c2b2cfc61 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -735,6 +735,8 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
>  		  size_t offset, u32 opt_flags)
>  {
>  	struct firmware *fw = NULL;
> +	struct cred *kern_cred = NULL;
> +	const struct cred *old_cred;
>  	bool nondirect = false;
>  	int ret;
>  
> @@ -751,6 +753,18 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
>  	if (ret <= 0) /* error or already assigned */
>  		goto out;
>  
> +	/*
> +	 * We are about to try to access the firmware file. Because we may have been
> +	 * called by a driver when serving an unrelated request from userland, we use
> +	 * the kernel credentials to read the file.
> +	 */
> +	kern_cred = prepare_kernel_cred(NULL);

This triggers quite some leak reports from kmemleak.

unreferenced object 0xffff0801e47690c0 (size 176):
  comm "kworker/0:1", pid 14, jiffies 4294904047 (age 2208.624s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
     kmem_cache_alloc
     prepare_kernel_cred
     _request_firmware
     firmware_request_nowarn
     firmware_request_nowarn at drivers/base/firmware_loader/main.c:933
     nvkm_firmware_get [nouveau]
     nvkm_firmware_get at drivers/gpu/drm/nouveau/nvkm/core/firmware.c:92
     nvkm_firmware_load_name [nouveau]
     nvkm_acr_lsfw_load_bl_inst_data_sig [nouveau]
     gm200_gr_load [nouveau]
     gf100_gr_new_ [nouveau]
     tu102_gr_new [nouveau]
     nvkm_device_ctor [nouveau]
     nvkm_device_pci_new [nouveau]
     nouveau_drm_probe [nouveau]
     local_pci_probe
     work_for_cpu_fn
     process_one_work


> +	if (!kern_cred) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +	old_cred = override_creds(kern_cred);
> +
>  	ret = fw_get_filesystem_firmware(device, fw->priv, "", NULL);
>  
>  	/* Only full reads can support decompression, platform, and sysfs. */
> @@ -776,6 +790,8 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
>  	} else
>  		ret = assign_fw(fw, device);
>  
> +	revert_creds(old_cred);
> +
>   out:
>  	if (ret < 0) {
>  		fw_abort_batch_reqs(fw);
> -- 
> 2.36.0.rc2.479.g8af0fa9b8e-goog
> 
