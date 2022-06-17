Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A226554FC37
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 19:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382711AbiFQR3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 13:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbiFQR3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 13:29:21 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3133205C;
        Fri, 17 Jun 2022 10:29:20 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 00AD7218DC;
        Fri, 17 Jun 2022 17:29:19 +0000 (UTC)
Received: from pdx1-sub0-mail-a312.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 5B9DB2167D;
        Fri, 17 Jun 2022 17:29:18 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1655486958; a=rsa-sha256;
        cv=none;
        b=oVYT/5RYSih/8rgXLkrhzfCN0C08fCDQJsej221KTz8Tdb9DnJAT8yEJ5H9z5vXOY+WXn3
        X/cEYDU5MByK7BD/+nZX/XH9NuqCTlY96ZUC2LYe1I8p8NZYTn9/yR2lVs1JrA+GEbXpXb
        5onhRA/zMt2E2Z8IBPqNVrkglP4a47sDnOpriI5JaJsUU8tm0Oc6zgI4slrS23Tm1EO2Iq
        p3bdeH0ND1gUjCUlhuVq5XF8/bTfyUCOAmjpPAFWaifR4shaS0ATxK5iXNmfr6sHDlftMg
        f70sZw2jLTKhpltkzAJMWvdmwJ18JL3g4OVaO9N+Ir9pl6uj8KN4i3uJRKGF9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1655486958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=XUhxfqkQF0CU6lxm1krsKg0S5OJ0VBWKBoWrBpq9l+A=;
        b=JCguzBxNpYgQHZEgY9JVDQvFRoNX7dVE0ANylY0neYg81MKUoSMIp/WXwzyJs06WKlwGyX
        hnZ+d4uiEJfklZB0peZZmu2PI+QJS95PxquA56qnQJv9s4Na+EPGjFyEbHsitwsXmtDNxF
        GAsNcs/86so679w7bmsEtT5G6rHWnKwJ/BYDrElZRcIR5uLbpFSOckQB51x00a2SqwTtPy
        yyJBz7rbKx5MnkLqhvsLlbfNitPTj8t0G08ajv/OomKKe4Go6Vdt1LoxCOSI1TB87y7gOn
        P/e9k0vrIrTXRlAMiDLtp6n3Sxntrnjd9riL3Ta44WZ0DdmfGa5wHPuUXmjj3g==
ARC-Authentication-Results: i=1;
        rspamd-786f5898df-6kl2s;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Spot-Towering: 74eb339b6801f420_1655486958762_3508439182
X-MC-Loop-Signature: 1655486958761:920235066
X-MC-Ingress-Time: 1655486958761
Received: from pdx1-sub0-mail-a312.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.120.38.187 (trex/6.7.1);
        Fri, 17 Jun 2022 17:29:18 +0000
Received: from offworld (unknown [104.36.31.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a312.dreamhost.com (Postfix) with ESMTPSA id 4LPmHd3DHhz23;
        Fri, 17 Jun 2022 10:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1655486958;
        bh=XUhxfqkQF0CU6lxm1krsKg0S5OJ0VBWKBoWrBpq9l+A=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=HZ8MG0XTWBBd41YED0zKMamelXCXKAZhqiQiTeH++3V8zqZu4yeMNZLAjlSX7X3R6
         iN5F22naXkhj8OCLCJxGLJ5QJb4neq/8jjWHQRmL0m4fHODLAAI3ud1yKJYXu+LUlf
         yXnRWhtGM7sqb80Qy7RnE1gwU9xR4dFjdLCwk1fb7DlcOBP5P5xXjOczWimsFiRwYD
         OrN4nJOqzUhAzdCiWHN+Ir4psvgqREGAOXhRQWlTDj8JAKNfd1HY7QfE81WKFwxMzj
         YI9Inrf9+DejSjO2B8j1XAlBckD/sG2LvXbTzT4+IbY/qxu+Rl8a7R4+wZG2yr0Myx
         N/ebiK3oW7P3Q==
Date:   Fri, 17 Jun 2022 10:29:14 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        a.manzanares@samsung.com
Subject: Re: [PATCH 2/3] cxl/mbox: Add GET_POISON_LIST mailbox command support
Message-ID: <20220617172914.k2rsotpwlp3wo5cm@offworld>
References: <cover.1655250669.git.alison.schofield@intel.com>
 <382a9c35ef43e89db85670637d88371f9197b7a2.1655250669.git.alison.schofield@intel.com>
 <20220617150508.0000266a@Huawei.com>
 <20220617162935.GA1532720@alison-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220617162935.GA1532720@alison-desk>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jun 2022, Alison Schofield wrote:

>On Fri, Jun 17, 2022 at 07:05:08AM -0700, Jonathan Cameron wrote:
>> On Tue, 14 Jun 2022 17:10:27 -0700
>> alison.schofield@intel.com wrote:
>>
>> > From: Alison Schofield <alison.schofield@intel.com>
>> >
>> > CXL devices that support persistent memory maintain a list of locations
>> > that are poisoned or result in poison if the addresses are accessed by
>> > the host.
>> >
>> > Per the spec (CXL 2.0 8.2.8.5.4.1), the device returns this Poison
>> > list as a set of  Media Error Records that include the source of the
>> > error, the starting device physical address and length. The length is
>> > the number of adjacent DPAs in the record and is in units of 64 bytes.
>> >
>> > Retrieve the list and log each Media Error Record as a trace event of
>> > type cxl_poison_list.
>> >
>> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
>>
>> A few more things inline.
>>
>> Otherwise, can confirm it works with some hack QEMU code.
>> I'll tidy that up and post soon.
>>
>> > +int cxl_mem_get_poison_list(struct device *dev)
>> > +{
>snip
>> > +
>> > +			trace_cxl_poison_list(dev, source, addr, len);
>>
>> Need to mask off the lower 6 bits of addr as they contain the source
>> + a few reserved bits.
>>
>> I was confused how you were geting better than 64 byte precision in your
>> example.
>>
>Ah...got it. Thanks!
>
>> > +		}
>> > +
>> > +		/* Protect against an uncleared _FLAG_MORE */
>> > +		nr_records = nr_records + le16_to_cpu(po->count);
>> > +		if (nr_records >= cxlds->poison_max)
>> > +			goto out;
>> > +
>> > +	} while (po->flags & CXL_POISON_FLAG_MORE);
>> So.. A conundrum here.  What happens if:
>>
>> 1. We get an error mid way through a set of multiple reads
>>    (something intermittent - maybe a software issue)
>> 2. We will drop out of here fine and report the error.
>> 3. We run this function again.
>>
>> It will (I think) currently pick up where we left off, but we have
>> no way of knowing that as there isn't a 'total records' count or
>> any other form of index in the output payload.
>
>Yes. That is sad. I'm assume it's by design and CXL devices never
>intended to keep any totals.
>
>>
>> So, software solutions I think should work (though may warrant a note
>> to be added to the spec).
>>
>> 1. Read whole thing twice. First time is just to ensure we get
>>    to the end and flush out any prior half done reads.
>> 2. Issue a read for a different region (perhaps length 0) first
>>    and assume everything starts from scratch when we go back to
>>    this region.
>
>Can you tell me more about 2 ?
>
>Also, Since posting this I have added protection to this path to ensure
>only one reader of the poison list for this device. Like this:

I don't think we should prevent multiple list reads. I would expect the
scenario Jonathan describes to be the uncommon case.

Thanks,
Davidlohr

>
>if (!completion_done(&cxlds->read_poison_complete);
>              return -EBUSY;
>wait_for_completion_interruptible(&cxlds->read_poison_complete);
>	...GET ALL THE POISON...
>complete(&cxlds->read_poison_complete);
>
>And will add the error message on that unexpected _FLAG_MORE too.
>
>Alison
>>
>> Jonathan
>>
>
>
>
>> > +
>> > +out:
>> > +	kvfree(po);
>> > +	return rc;
>> > +}
>> > +EXPORT_SYMBOL_NS_GPL(cxl_mem_get_poison_list, CXL);
>> > +
>> >  struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
>> >  {
>> >	struct cxl_dev_state *cxlds;
>>
