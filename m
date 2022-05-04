Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D574B519D19
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 12:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348224AbiEDKli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 06:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348200AbiEDKl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 06:41:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA62D28E0F;
        Wed,  4 May 2022 03:37:53 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651660672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lzcPu6GZE6ZiaZyABqJBDH3V4kDcq2cOcg6QCnZEcyw=;
        b=ovf/Csmq3jTKaCHL/duZUMzM92UA3ybQPuPS/yR4hQyfMAMiBVXU2uBCn6ChoPSyXAfSo9
        bJjhZS94xj7/+QmApH28oJm11Br3PWNSOxp1bUXPqx0rKKdknFjls32DU4SjFa6h2mC9FG
        q+7A5c8xCM1uB60EOvOpVDYCGB+3oW7z4fhOZPG0gkHa//xQgwJAnB9xjOQo5rt++R0SpH
        m3vrDOqhmxFOjkWIraav8Qi6m439Z9DQ1Hn/IY5cMJrQm2FnbzXAZlSiy/4krl1VYmxGXF
        thd/N4iuIhQtjYbGFsrQuRI05DW6z/ZpBhjKJJkcCwB2D2NBsXJyx114mB8ULQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651660672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lzcPu6GZE6ZiaZyABqJBDH3V4kDcq2cOcg6QCnZEcyw=;
        b=BC/5VsG6lYSZc3t+ojfusr5IIyCrAsxHoz70LVlfMswd0nu2Kajh4YcdNrqzUc0s9vB/WZ
        ovNrwvd3WjLTtJCw==
To:     Tony Luck <tony.luck@intel.com>, hdegoede@redhat.com,
        markgross@kernel.org
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        jithu.joseph@intel.com, ashok.raj@intel.com, tony.luck@intel.com,
        rostedt@goodmis.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com
Subject: Re: [PATCH v5 04/10] platform/x86/intel/ifs: Read IFS firmware image
In-Reply-To: <20220428153849.295779-5-tony.luck@intel.com>
References: <20220422200219.2843823-1-tony.luck@intel.com>
 <20220428153849.295779-1-tony.luck@intel.com>
 <20220428153849.295779-5-tony.luck@intel.com>
Date:   Wed, 04 May 2022 12:37:52 +0200
Message-ID: <87wnf1k2gv.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28 2022 at 08:38, Tony Luck wrote:
> +/*
> + * Load ifs image. Before loading ifs module, the ifs image must be located
> + * in /lib/firmware/intel/ifs and named as {family/model/stepping}.{testname}.
> + */
> +void ifs_load_firmware(struct device *dev)
> +{
> +	const struct firmware *fw;
> +	char scan_path[32];
> +	int ret;
> +
> +	snprintf(scan_path, sizeof(scan_path), "intel/ifs/%02x-%02x-%02x.scan",
> +		 boot_cpu_data.x86, boot_cpu_data.x86_model, boot_cpu_data.x86_stepping);
> +
> +	ret = request_firmware_direct(&fw, scan_path, dev);
> +	if (ret) {
> +		dev_err(dev, "ifs file %s load failed\n", scan_path);
> +		return;

Why is this not returning an error to the caller?

Thanks,

        tglx
