Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C882F55D593
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245741AbiF1Gdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 02:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343499AbiF1Gdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 02:33:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA4BB71
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 23:33:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D0A4618FB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:33:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0FBC3411D;
        Tue, 28 Jun 2022 06:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656398006;
        bh=3Gb+thKC8tBOSqjuQCp0B4dhsLQzuckBwDvfum6vQ7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TZZtP7prTZccZ6iGBBpF9SMGg+lcXsWBSD5ClLMSPCUTxGTYSk+Z1FDXNZdp3g3qe
         s4OpHkjRVFwIor2863TvVsm6eNNdeTtG3yL+30ThzY7qe0eDqHe8fWfXjECmK7smnM
         BHPzPpT+Buu5/IuEom4b4m8FnCQAHEydKBXehoF8=
Date:   Tue, 28 Jun 2022 08:33:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/12] uapi: habanalabs: add gaudi2 defines
Message-ID: <Yrqgs9koXkfIG1KI@kroah.com>
References: <20220627202620.961350-1-ogabbay@kernel.org>
 <20220627202620.961350-3-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627202620.961350-3-ogabbay@kernel.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 11:26:10PM +0300, Oded Gabbay wrote:
> @@ -456,7 +841,7 @@ struct hl_info_hw_ip_info {
>  	__u32 num_of_events;
>  	__u32 device_id;
>  	__u32 module_id;
> -	__u32 reserved;
> +	__u32 decoder_enabled_mask;
>  	__u16 first_available_interrupt_id;
>  	__u16 server_type;
>  	__u32 cpld_version;
> @@ -466,12 +851,13 @@ struct hl_info_hw_ip_info {
>  	__u32 psoc_pci_pll_div_factor;
>  	__u8 tpc_enabled_mask;
>  	__u8 dram_enabled;
> -	__u8 pad[2];
> +	__u8 reserved;
> +	__u8 mme_master_slave_mode;

You are moving fields around (reserved moved to a different spot, and
you were checking that reserved was always 0, right?) and renaming them.
Is that going to break userspace?




>  	__u8 cpucp_version[HL_INFO_VERSION_MAX_LEN];
>  	__u8 card_name[HL_INFO_CARD_NAME_MAX_LEN];
> -	__u64 reserved2;
> +	__u64 tpc_enabled_mask_ext;
>  	__u64 dram_page_size;
> -	__u32 reserved3;
> +	__u32 edma_enabled_mask;
>  	__u16 number_of_user_interrupts;
>  	__u16 pad2;
>  	__u64 reserved4;
> @@ -722,6 +1108,44 @@ struct hl_info_dev_memalloc_page_sizes {
>  	__u64 page_order_bitmask;
>  };
>  
> +#define HL_TPM_PCR_DATA_BUF_SZ		256
> +#define HL_TPM_PCR_QUOTE_BUF_SZ		510	/* (512 - 2) 2 bytes used for size */
> +#define HL_TPM_SIGNATURE_BUF_SZ		255	/* (256 - 1) 1 byte used for size */
> +#define HL_TPM_PUB_DATA_BUF_SZ		510	/* (512 - 2) 2 bytes used for size */
> +#define HL_TPM_CERTIFICATE_BUF_SZ	2046	/* (2048 - 2) 2 bytes used for size */
> +
> +/**
> + * struct hl_info_tpm - attestation data of the boot from the TPM
> + * @nonce: number only used once. random number provided by host. this also passed to the quote
> + *         command as a qualifying data.
> + * @pcr_quote_len: length of the attestation quote data in bytes
> + * @pub_data_len: length of the public data in bytes
> + * @certificate_len: length of the certificate in bytes
> + * @pcr_num_reg: number of PCR registers in the pcr_data array
> + * @pcr_reg_len: length of each PCR register in the pcr_data array in bytes
> + * @quote_sig_len: length of the attestation signature in bytes
> + * @pcr_data: raw values of the PCR registers from the TPM
> + * @pcr_quote: attestation data structure (TPM2B_ATTEST) from the TPM
> + * @public_data: public key and certificate info from the TPM (outPublic + name + qualifiedName)
> + * @certificate: certificate for the attestation data, read from the TPM NV mem
> + * @quote_sig: signature structure (TPMT_SIGNATURE) of the attestation data
> + */
> +struct hl_info_tpm {
> +	__u32 nonce;
> +	__u16 pcr_quote_len;
> +	__u16 pub_data_len;
> +	__u16 certificate_len;
> +	__u8 pcr_num_reg;
> +	__u8 pcr_reg_len;
> +	__u8 quote_sig_len;
> +	__u8 pcr_data[HL_TPM_PCR_DATA_BUF_SZ];
> +	__u8 pcr_quote[HL_TPM_PCR_QUOTE_BUF_SZ];
> +	__u8 public_data[HL_TPM_PUB_DATA_BUF_SZ];
> +	__u8 certificate[HL_TPM_CERTIFICATE_BUF_SZ];
> +	__u8 quote_sig[HL_TPM_SIGNATURE_BUF_SZ];
> +	__u8 pad0[2];

Do you always check that pad0 is set to 0 in the kernel code?

> +};
> +
>  enum gaudi_dcores {
>  	HL_GAUDI_WS_DCORE,
>  	HL_GAUDI_WN_DCORE,
> @@ -742,6 +1166,7 @@ enum gaudi_dcores {
>   * @period_ms: Period value, in milliseconds, for utilization rate in range 100ms - 1000ms in 100 ms
>   *             resolution. Currently not in use.
>   * @pll_index: Index as defined in hl_<asic type>_pll_index enumeration.
> + * @tpm_nonce: Nonce number used for tpm attestation.
>   * @eventfd: event file descriptor for event notifications.
>   * @pad: Padding to 64 bit.
>   */
> @@ -755,6 +1180,7 @@ struct hl_info_args {
>  		__u32 ctx_id;
>  		__u32 period_ms;
>  		__u32 pll_index;
> +		__u32 tpm_nonce;
>  		__u32 eventfd;
>  	};

You added a new field to the middle of a structure, did that just break
userspace built with the old structure from working with a new kernel?

> @@ -1400,7 +1837,16 @@ struct hl_debug_params_bmon {
>  
>  	/* Trace source ID */
>  	__u32 id;
> -	__u32 pad;
> +
> +	/* Control register */
> +	__u32 control;
> +
> +	/* Two more address ranges that the user can request to filter */
> +	__u64 start_addr2;
> +	__u64 end_addr2;
> +
> +	__u64 start_addr3;
> +	__u64 end_addr3;
>  };

Adding to the end is good, but again, will old userspace and new kernel
still work properly?

>  
>  struct hl_debug_params_spmu {
> @@ -1409,7 +1855,11 @@ struct hl_debug_params_spmu {
>  
>  	/* Number of event types selection */
>  	__u32 event_types_num;
> -	__u32 pad;
> +
> +	/* TRC configuration register values */
> +	__u32 pmtrc_val;
> +	__u32 trc_ctrl_host_val;
> +	__u32 trc_en_host_val;
>  };

Same here, you increased the size.

thanks,

greg k-h
