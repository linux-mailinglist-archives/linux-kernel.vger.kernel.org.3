Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A95354CD1D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346162AbiFOPdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244694AbiFOPdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:33:19 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971C11C120
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655307198; x=1686843198;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hr/Spzo+KlJMSRYPm1IaNGTgBVN+sjW/tx4ctcrcIcs=;
  b=K8uKwXU02UndPZBr4kELvVgA+rmz486UT7Nsben/Ttl2Jd9Gj9Ubh8v+
   NwVAjXhBA+hfqP5jpO00bwi9AVV9O9himQUXTCwnYJm4R6NCWFIrDs1yd
   Ez2GiHKr3nyo9VeW8tkUll/QC0Btk+dCqPk2+92ZXVUhtJZx87DwIRD+l
   6sfSY031bxSw5dm6havyeLqKmQQ5Nf52uKlU4mdPgCTF/kQP0UCcuXudA
   Qx7ijwD71tdcoZMf0dWi0Yjp9Kg48Hdax/i8INLNGfPoJ3wW7YHEAMUVS
   IDF5HPx9ypwDzEbVxiM3VUYpKWgBFNQ9qA2FMcag0o+0Iox0haIVU6RcW
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="342960537"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="342960537"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 08:33:17 -0700
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="559177771"
Received: from mjortiz-mobl.amr.corp.intel.com (HELO [10.212.185.241]) ([10.212.185.241])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 08:33:16 -0700
Message-ID: <c69f2023-f518-72cd-9991-c672b40d3767@intel.com>
Date:   Wed, 15 Jun 2022 08:33:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] arch: x86: kernel: Add missing of_node_put() in
 devicetree.c
Content-Language: en-US
To:     Liang He <windhl@126.com>, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, robh@kernel.org, frank.rowand@sony.com,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
References: <20220615150325.3969911-1-windhl@126.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220615150325.3969911-1-windhl@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/22 08:03, Liang He wrote:
> In dtb_setup_hpet(), of_find_compatible_node() will return a node
> pointer with refcount incremented. We should use of_node_put() when it
> is not used anymore.
> 
> Signed-off-by: Liang He <windhl@126.com>

Seems like:

Fixes: ffb9fc68dff3 ("x86: dtb: Add device tree support for HPET")

and would be appropriate, right?

Also, how was this found, and what is the impact from not fixing it?
Was it causing horrible problems in production, or was it just something
that was found by inspection that's not causing any real problems in
practice?
