Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59C759EABF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 20:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiHWSQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 14:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234173AbiHWSPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 14:15:40 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99CF2AEC;
        Tue, 23 Aug 2022 09:30:14 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id BE75A5009F1;
        Tue, 23 Aug 2022 16:30:13 +0000 (UTC)
Received: from pdx1-sub0-mail-a302.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id C7941500908;
        Tue, 23 Aug 2022 16:30:12 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1661272213; a=rsa-sha256;
        cv=none;
        b=45EsG5hGptRVVciF7oayheOL9ijXVg9G/etAuC28lib6FEarS83fO3c94tL/krnPW/3gb5
        BHkRtA7LPymO4D+ENOr5MxF+BczZMxJmNua87Mf+gq+xYIDMVUu3kpDEbqmusHAbjx9049
        zOS924d9WX/GJ205iodf8tglf4KXubhVh+pyDk6Fm2h1BjqhHHBiF1sUBHItCpYi71wbL4
        Q4wpgEebQyQsN7xTPKqkdlwYDTS91nHn94wbU3fPLpCUaINU7rcI9pyWkgRFT6Tx4D/ed+
        YVgGUFpHxVQ6JsTeMzHdwopsaJ1Ivgxvpg54zxF0YyNo2f65wvnkPLrArOUbRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1661272213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=uDD/E4CoF8RiYGRs7gzGC7gviushfq4mXW+ilp398lg=;
        b=tkT1g3SufCo+GIXimGRmJeoPjgkSKRD5tPUUPocUaLIqB+BwjxulDvc4UT08EL4W0xM7pR
        ZPi2v7uGxtfrXmZ+Hy6NOVruJ0h9DxZC3VZ20ugV821HaTpPWuuxZQg+eEd7guzgyE1MrP
        tv/9pbzCSz/T1coUUwOTr4QXfMp/ewrYSkVjlrDm4ikFxPfXvtMNHHV6G4cm/aMnLPSLbI
        gjUh1hlEf/WnkkdVFpEG4aVOUlo5ptpIHQiH3GupeZ9qRJswWVdbFReK+VF7OZMzl9bELB
        MTZrihgYWOZpuRvpD+pZXkwbnnyT7MUe/nK2U920KEuaWDgqKPr1Hu9tJW8xyg==
ARC-Authentication-Results: i=1;
        rspamd-76867cc9c5-7mzwg;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Share-Tasty: 166b41da78db7f24_1661272213430_2395831673
X-MC-Loop-Signature: 1661272213430:136564985
X-MC-Ingress-Time: 1661272213430
Received: from pdx1-sub0-mail-a302.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.98.142.74 (trex/6.7.1);
        Tue, 23 Aug 2022 16:30:13 +0000
Received: from offworld (unknown [104.36.31.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a302.dreamhost.com (Postfix) with ESMTPSA id 4MBvpW4B8Bz22Z;
        Tue, 23 Aug 2022 09:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1661272212;
        bh=uDD/E4CoF8RiYGRs7gzGC7gviushfq4mXW+ilp398lg=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=jEpT7t3/zdjo6ndvHXrH8tsguWjnEpDx4WSI8OOhTVb05E6+L/5uMrvPkDBs3t4GJ
         WEtHhmv45OYz/nx9O7q5be/rIsfOyxnk7QYjxDRJZnp4C2P0UqD+/tbYfaOCyUvH13
         YO07QLDO7hudIU915JkRk09YLrR6qhaaOwrm0qt56VlJRNPwFgLXfOq0Ylgp2PBhNL
         EbWGA7EuK/nSamqBsH2D9sWRS+4wWiAZl7BKdVRzqrpHjUvZQYc+lZ5bV0n2H+yFFF
         adyZpe96WXFhlUbPACgixF4mgMMLZFlFBxnAH/krvpgpatMA1dmUWrWU/5d8wi0abM
         Lp6vWhKbSSjNg==
Date:   Tue, 23 Aug 2022 09:12:08 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        a.manzanares@samsung.com, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org
Subject: Re: [RFC PATCH 0/9] CXL: Read and clear event logs
Message-ID: <20220823161208.hyiripnf7gy6r4ks@offworld>
References: <20220813053243.757363-1-ira.weiny@intel.com>
 <20220822161802.h47v7yfrqufeltqt@offworld>
 <YwQJAqThYczUHhOB@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YwQJAqThYczUHhOB@iweiny-desk3>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Aug 2022, Ira Weiny wrote:

>Generally it seems ok but I have questions below.
>
>> One thing I have not
>> considered in this is the DOE stuff.
>
>I think this is the harder thing to support because of needing to allow both
>the PCI layer and the CXL layer to create irqs.  Potentially at different
>times.

I agree.

>> -/* Register Block Identifier (RBI) */
>> -enum cxl_regloc_type {
>> -	CXL_REGLOC_RBI_EMPTY = 0,
>> -	CXL_REGLOC_RBI_COMPONENT,
>> -	CXL_REGLOC_RBI_VIRT,
>> -	CXL_REGLOC_RBI_MEMDEV,
>> -	CXL_REGLOC_RBI_TYPES
>> -};
>
>Why move this?

That was sloppy of me, sorry. I wanted to reuse struct cxlds forward declaration,
no idea why that diff formed.

>> -
>>  static inline resource_size_t cxl_regmap_to_base(struct pci_dev *pdev,
>>						 struct cxl_register_map *map)
>>  {
>> @@ -75,4 +66,44 @@ int devm_cxl_port_enumerate_dports(struct cxl_port *port);
>>  struct cxl_dev_state;
>>  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm);
>>  void read_cdat_data(struct cxl_port *port);
>> +
>> +#define CXL_IRQ_CAPABILITY_TABLE				\
>> +	C(ISOLATION, "isolation", NULL),			\
>> +	C(PMU, "pmu_overflow", NULL), /* per pmu instance */	\
>> +	C(MBOX, "mailbox", NULL), /* primary-only */		\
>> +	C(EVENT, "event", NULL),
>
>This is defining get_max_msgnum to NULL right?

Yes. So untl there are any users everything's a nop.

>> +
>> +#undef C
>> +#define C(a, b, c) CXL_IRQ_CAPABILITY_##a
>> +enum  { CXL_IRQ_CAPABILITY_TABLE };
>> +#undef C
>> +#define C(a, b, c) { b, c }
>> +/**
>> + * struct cxl_irq_cap - CXL feature that is capable of receiving MSI/MSI-X irqs.
>> + *
>> + * @name: Name of the device generating this interrupt.
>> + * @get_max_msgnum: Get the feature's largest interrupt message number. In cases
>> + *                  where there is only one instance it also indicates which
>> + *                  MSI/MSI-X vector is used for the interrupt message generated
>> + *                  in association with the feature. If the feature does not
>> + *                  have the Interrupt Supported bit set, then return -1.
>> + */
>> +struct cxl_irq_cap {
>> +	const char *name;
>> +	int (*get_max_msgnum)(struct cxl_dev_state *cxlds);
>> +};
>> +
>> +static const
>> +struct cxl_irq_cap cxl_irq_cap_table[] = { CXL_IRQ_CAPABILITY_TABLE };
>> +#undef C
>
>Why all this macro magic?

A nifty trick Dan likes, it avoids duplicating the fields (enums + the table).

>> +
>> +/* Register Block Identifier (RBI) */
>> +enum cxl_regloc_type {
>> +	CXL_REGLOC_RBI_EMPTY = 0,
>> +	CXL_REGLOC_RBI_COMPONENT,
>> +	CXL_REGLOC_RBI_VIRT,
>> +	CXL_REGLOC_RBI_MEMDEV,
>> +	CXL_REGLOC_RBI_TYPES
>> +};
>> +
>>  #endif /* __CXL_PCI_H__ */
>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index faeb5d9d7a7a..c0fe78e0559b 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -387,6 +387,52 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>>	return rc;
>>  }
>>
>> +static void cxl_pci_free_irq_vectors(void *data)
>> +{
>> +	pci_free_irq_vectors(data);
>> +}
>> +
>> +static int cxl_pci_alloc_irq_vectors(struct cxl_dev_state *cxlds)
>> +{
>> +	struct device *dev = cxlds->dev;
>> +	struct pci_dev *pdev = to_pci_dev(dev);
>> +	int rc, i, vectors = -1;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(cxl_irq_cap_table); i++) {
>> +		int irq;
>> +
>> +		if (!cxl_irq_cap_table[i].get_max_msgnum)
>> +			continue;
>> +
>> +		irq = cxl_irq_cap_table[i].get_max_msgnum(cxlds);
>> +		vectors = max_t(int, irq, vectors);
>> +	}
>> +
>> +	if (vectors == -1)
>> +		return -EINVAL; /* no irq support whatsoever */
>> +
>> +	vectors++;
>
>This is pretty much what earlier versions of the DOE code did with the
>exception of only have 1 get_max_msgnum() calls defined (for DOE).  But there
>was a lot of debate about how to share vectors with the PCI layer.  And
>eventually we got rid of it.  I'm still trying to figure it out.  Sorry for
>being slow.

That makes sense, thanks for the explanation. And no not slow, it is _I_
that needs to go re-read the DOE stuff with more attention. But while I
knew this was the hardest part, all I really wanted was a basic irq
support to add to the bg cmd handling series.

>Perhaps we do this for this series.  However, won't we have an issue if we want
>to support switch events?

If possible, could you elaborate more on this?

Thanks,
Davidlohr
