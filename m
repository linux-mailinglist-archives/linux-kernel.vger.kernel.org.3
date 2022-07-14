Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879245757C0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 00:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240647AbiGNWla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 18:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGNWl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 18:41:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED116EE84;
        Thu, 14 Jul 2022 15:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=dF8P5lISOtudOc5lOEvkHblck5rhWyzYdp8lqqJ3+zw=; b=D9FGt5VqSNX0rsos3zTvPMyDFR
        UZnT82UcOpsn7UobKS+m0vYaem/Z+clRc8Nopat5VtPsgycp0FdSiVnra/1L2ubqgbQHH2CV5SCph
        LNDnfhyb1OGCSsw3peijBxcBkmH8Hu8xr1KDKfFiFxyuYL4QB/2Jm1NTAn35hRAuldkXQp6V3QSPh
        QGeAvtLqANohYScyXdwtdTd+d58a6MQW053ls525MD8vqv00Xqa2FgfnX+cRu0eyVZgRYaFcQPv4t
        QFB6Adm7oFbd+xIM9wcmTpwNfm1cSxXUHqpHT3ejs8WtSJ9KbXxkO186NONdfbRhADxwUGnLh4Mp0
        OCT9xCTw==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oC7WP-0026H6-JW; Thu, 14 Jul 2022 22:41:25 +0000
Message-ID: <fb9751d2-0ca1-2d6b-bd3d-e008a7676f43@infradead.org>
Date:   Thu, 14 Jul 2022 15:41:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 05/11] virt: gunyah: Add sysfs nodes
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Trilok Soni <quic_tsoni@quicinc.com>,
        Murali Nalajala <quic_mnalajala@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagiri@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org
References: <20220223233729.1571114-1-quic_eberman@quicinc.com>
 <20220714212940.2988436-1-quic_eberman@quicinc.com>
 <20220714212940.2988436-6-quic_eberman@quicinc.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220714212940.2988436-6-quic_eberman@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/14/22 14:29, Elliot Berman wrote:
> diff --git a/drivers/virt/gunyah/Kconfig b/drivers/virt/gunyah/Kconfig
> new file mode 100644
> index 000000000000..e88289963518
> --- /dev/null
> +++ b/drivers/virt/gunyah/Kconfig
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config GUNYAH
> +	tristate "Gunyah Virtualization drivers"
> +	depends on ARM64
> +	select SYS_HYPERVISOR
> +	help
> +	  The Gunyah drivers are the helper interfaces that runs in a guest VM
> +	  such as basic inter-VM IPC and signaling mechanism,s and higher level

	Drop the "comma" ..................................^^^^

> +	  services such as memory/device sharing, IRQ sharing, and so on.
> +
> +	  Say Y here to enable the drivers needed to interact in a Gunyah
> +	  virtual environment.

-- 
~Randy
