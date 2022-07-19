Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF97857A3B8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 17:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239376AbiGSPxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 11:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239365AbiGSPxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 11:53:47 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58725405D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:53:45 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id h132so13846229pgc.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=97PrQlIB8/07EwQL9gOpc20PS5FL9FE1rwJO80C1yVM=;
        b=UPim7G55cZS0qbyf/En9E8FI/NhxptHgmYuDWQzwtpEQyojz3bZGdpj23WjBFWGs4j
         WR91KmwclDvXUhcO6AmCwOM+gW1k7KmwNncAv/4uMzgMP3YLlQxoQfV9inHkHQFamXho
         DlOzPi581rMHGTa4ypb6FDQaTJopFk5kllqZWBoUnfGEK39q3T19q00IINOBd9jT0P/+
         BXfhh2Eehvezwa0+dO6SjyB9lKP2Kj9Vz381fzfsDM9OPNyElm6611TAAg5Dzrhs6i/7
         JDHRnRY+bsTXv4m8u+4MtnC20HmsTSsyr5G97faGyLM2F+ZJJww09fBzX3YiSYSOSIZ3
         Di0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=97PrQlIB8/07EwQL9gOpc20PS5FL9FE1rwJO80C1yVM=;
        b=WRqScwlSVCsAsXWxwnXXefPuJ0w5+ny0l7tJlGfVGl9BZ8vIoLSmEtTbhmpzYTG4f2
         wSfqy1sWcgUdbuu4noYfWtzerI45UT4a2DJ6tQHDswJV165RR9sKUW3ZlsTLVmBbPF+z
         HiZAXKAGVXkdpFRkTRIhWuCbPcF3eAIKkC7hii0Czg+Qy85nG57PeBjVKFiBYefEcx5K
         ytSDSSKSm1NZC0FQOLsQlc4lPYkststX+BE1cMNQpagMP5ltsWqI+treO+A96pEN4PkM
         DwNHqARfhPgdL6zfEZA4f3PElsMx0kGdbuIVR3X+ADKMnqVV0G6SK58rBBgOpzbmfZzS
         1ksQ==
X-Gm-Message-State: AJIora8JbSBhsWe6b2+wmrFrH3GWdl1gPpUGoQiNu5gIIA0LsULTOxl3
        QzKen6lBK6xiNtu2tJJLwr3qiQ==
X-Google-Smtp-Source: AGRyM1tkkiudUZbVg8XqOG/4Xa31HkkoEf7SZ2OfYCY0g4XW4BuT8wvr+CAoqB68Sklx9GpLmM3C5A==
X-Received: by 2002:a05:6a00:1781:b0:528:c839:9886 with SMTP id s1-20020a056a00178100b00528c8399886mr34310041pfg.71.1658246024535;
        Tue, 19 Jul 2022 08:53:44 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id o17-20020a170902779100b0015e8d4eb27esm11779414pll.200.2022.07.19.08.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 08:53:43 -0700 (PDT)
Date:   Tue, 19 Jul 2022 09:53:40 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Puranjay Mohan <p-mohan@ti.com>
Cc:     linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        nm@ti.com, ssantosh@kernel.org, s-anna@ti.com,
        linux-arm-kernel@lists.infradead.org, rogerq@kernel.org,
        grygorii.strashko@ti.com, vigneshr@ti.com, kishon@ti.com,
        robh@kernel.org
Subject: Re: [PATCH v5 4/6] remoteproc: pru: Add pru_rproc_set_ctable()
 function
Message-ID: <20220719155340.GA3393732@p14s>
References: <20220607045650.4999-1-p-mohan@ti.com>
 <20220607045650.4999-5-p-mohan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607045650.4999-5-p-mohan@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 10:26:48AM +0530, Puranjay Mohan wrote:
> From: Roger Quadros <rogerq@ti.com>
> 
> Some firmwares expect the OS drivers to configure the CTABLE
> entries publishing dynamically allocated memory regions. For
> example, the PRU Ethernet firmwares use the C28 and C30 entries
> for retrieving the Shared RAM and System SRAM (OCMC) areas
> allocated by the PRU Ethernet client driver.
> 
> Provide a way for users to do that through a new API,
> pru_rproc_set_ctable(). The API returns 0 on success and
> a negative value on error.
> 
> NOTE:
> The programmable CTABLE entries are typically re-programmed by
> the PRU firmwares when dealing with a certain block of memory
> during block processing. This API provides an interface to the
> PRU client drivers to publish a dynamically allocated memory
> block with the PRU firmware using a CTABLE entry instead of a
> negotiated address in shared memory. Additional synchronization
> may be needed between the PRU client drivers and firmwares if
> different addresses needs to be published at run-time reusing
> the same CTABLE entry.

In all this the concept of a "ctable" is not explained and as such, I have to
guess it stands for "constant table".  I also have to guess this table stores
memory addresses known to other drivers, making it possible to boot a system
without all components having access to a DT.  Again, those are all guesses
because it is not explained.  And all that guessing makes reviewing this small
patchset quite difficult.

> 
> Co-developed-by: Andrew F. Davis <afd@ti.com>
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> Co-developed-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Co-developed-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
> Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
> Signed-off-by: Puranjay Mohan <p-mohan@ti.com>
> ---
>  drivers/remoteproc/pru_rproc.c | 59 ++++++++++++++++++++++++++++++++++
>  include/linux/pruss.h          | 22 +++++++++++++
>  2 files changed, 81 insertions(+)
> 
> diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
> index 9fed3e0372d3..d06b763e995e 100644
> --- a/drivers/remoteproc/pru_rproc.c
> +++ b/drivers/remoteproc/pru_rproc.c
> @@ -119,6 +119,7 @@ struct pru_private_data {
>   * @mapped_irq: virtual interrupt numbers of created fw specific mapping
>   * @pru_interrupt_map: pointer to interrupt mapping description (firmware)
>   * @pru_interrupt_map_sz: pru_interrupt_map size
> + * @rmw_lock: lock for read, modify, write operations on registers
>   * @dbg_single_step: debug state variable to set PRU into single step mode
>   * @dbg_continuous: debug state variable to restore PRU execution mode
>   * @evt_count: number of mapped events
> @@ -136,6 +137,7 @@ struct pru_rproc {
>  	unsigned int *mapped_irq;
>  	struct pru_irq_rsc *pru_interrupt_map;
>  	size_t pru_interrupt_map_sz;
> +	spinlock_t rmw_lock; /* register access lock */
>  	u32 dbg_single_step;
>  	u32 dbg_continuous;
>  	u8 evt_count;
> @@ -152,6 +154,23 @@ void pru_control_write_reg(struct pru_rproc *pru, unsigned int reg, u32 val)
>  	writel_relaxed(val, pru->mem_regions[PRU_IOMEM_CTRL].va + reg);
>  }
>  
> +static inline
> +void pru_control_set_reg(struct pru_rproc *pru, unsigned int reg,
> +			 u32 mask, u32 set)
> +{
> +	u32 val;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&pru->rmw_lock, flags);
> +
> +	val = pru_control_read_reg(pru, reg);
> +	val &= ~mask;
> +	val |= (set & mask);
> +	pru_control_write_reg(pru, reg, val);
> +
> +	spin_unlock_irqrestore(&pru->rmw_lock, flags);
> +}
> +
>  static struct rproc *__pru_rproc_get(struct device_node *np, int index)
>  {
>  	struct device_node *rproc_np = NULL;
> @@ -273,6 +292,45 @@ void pru_rproc_put(struct rproc *rproc)
>  }
>  EXPORT_SYMBOL_GPL(pru_rproc_put);
>  
> +/**
> + * pru_rproc_set_ctable() - set the constant table index for the PRU
> + * @rproc: the rproc instance of the PRU
> + * @c: constant table index to set
> + * @addr: physical address to set it to
> + *
> + * Return: 0 on success, or errno in error case.
> + */
> +int pru_rproc_set_ctable(struct rproc *rproc, enum pru_ctable_idx c, u32 addr)
> +{
> +	struct pru_rproc *pru = rproc->priv;
> +	unsigned int reg;
> +	u32 mask, set;
> +	u16 idx;
> +	u16 idx_mask;
> +
> +	if (IS_ERR_OR_NULL(rproc))
> +		return -EINVAL;
> +
> +	if (!rproc->dev.parent || !is_pru_rproc(rproc->dev.parent))
> +		return -ENODEV;
> +
> +	/* pointer is 16 bit and index is 8-bit so mask out the rest */
> +	idx_mask = (c >= PRU_C28) ? 0xFFFF : 0xFF;
> +
> +	/* ctable uses bit 8 and upwards only */
> +	idx = (addr >> 8) & idx_mask;
> +
> +	/* configurable ctable (i.e. C24) starts at PRU_CTRL_CTBIR0 */
> +	reg = PRU_CTRL_CTBIR0 + 4 * (c >> 1);
> +	mask = idx_mask << (16 * (c & 1));
> +	set = idx << (16 * (c & 1));
> +

Please add comments that describe the content and format of the CTABLE.
Otherwise this code becomes unmaintainable.

> +	pru_control_set_reg(pru, reg, mask, set);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pru_rproc_set_ctable);
> +
>  static inline u32 pru_debug_read_reg(struct pru_rproc *pru, unsigned int reg)
>  {
>  	return readl_relaxed(pru->mem_regions[PRU_IOMEM_DEBUG].va + reg);
> @@ -944,6 +1002,7 @@ static int pru_rproc_probe(struct platform_device *pdev)
>  	pru->rproc = rproc;
>  	pru->fw_name = fw_name;
>  	pru->client_np = NULL;
> +	spin_lock_init(&pru->rmw_lock);
>  	mutex_init(&pru->lock);
>  
>  	for (i = 0; i < ARRAY_SIZE(mem_names); i++) {
> diff --git a/include/linux/pruss.h b/include/linux/pruss.h
> index fdc719b43db0..d830e20056c7 100644
> --- a/include/linux/pruss.h
> +++ b/include/linux/pruss.h
> @@ -23,13 +23,29 @@ enum pruss_pru_id {
>  	PRUSS_NUM_PRUS,
>  };
>  
> +/*
> + * enum pru_ctable_idx - Configurable Constant table index identifiers
> + */
> +enum pru_ctable_idx {
> +	PRU_C24 = 0,
> +	PRU_C25,
> +	PRU_C26,
> +	PRU_C27,
> +	PRU_C28,
> +	PRU_C29,
> +	PRU_C30,
> +	PRU_C31,
> +};
> +
>  struct device_node;
> +struct rproc;
>  
>  #if IS_ENABLED(CONFIG_PRU_REMOTEPROC)
>  
>  struct rproc *pru_rproc_get(struct device_node *np, int index,
>  			    enum pruss_pru_id *pru_id);
>  void pru_rproc_put(struct rproc *rproc);
> +int pru_rproc_set_ctable(struct rproc *rproc, enum pru_ctable_idx c, u32 addr);
>  
>  #else
>  
> @@ -41,6 +57,12 @@ pru_rproc_get(struct device_node *np, int index, enum pruss_pru_id *pru_id)
>  
>  static inline void pru_rproc_put(struct rproc *rproc) { }
>  
> +static inline int pru_rproc_set_ctable(struct rproc *rproc,
> +				       enum pru_ctable_idx c, u32 addr)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  #endif /* CONFIG_PRU_REMOTEPROC */
>  
>  static inline bool is_pru_rproc(struct device *dev)
> -- 
> 2.17.1
> 
