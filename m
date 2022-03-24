Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDB64E5FA2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348618AbiCXHpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237386AbiCXHpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:45:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 87B937892B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 00:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648107828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2JkyU0YyumtNPR5ZrTimMZIYIDQ559h+78LrW1gfIvI=;
        b=V9PmdC+P+WYDrqvN5uPetSxBzZxUhwqVj5aStLsALvYPhgo06Q9NJBilN31TDX9w1URbD5
        4WyYq7BAdeC9N2UK1J0SpIeFLnBePjP8N6NgJajgDoCCWep8Mi7RbiWtsByMNcrO7UCzQ+
        BMdRUtOFiSoHYmJJSMRrvlGUd5M2S+I=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-451-kgsUNS4ROo-Egf0vZtbzNg-1; Thu, 24 Mar 2022 03:39:21 -0400
X-MC-Unique: kgsUNS4ROo-Egf0vZtbzNg-1
Received: by mail-ed1-f70.google.com with SMTP id z22-20020a50cd16000000b0041960ea8555so2508281edi.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 00:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2JkyU0YyumtNPR5ZrTimMZIYIDQ559h+78LrW1gfIvI=;
        b=XeODrMoI2gFgSjywUrXG2BLleW4NqOP4zAtpyBioGw++kjcQm3tvqDFNDBbmBzdsKZ
         b8MlKmtTnNAe9WkFE7g6WpdhBXv6Kx5jebu7M/7cPde6EnUjlQV1ROhnE6j7lPpN2/tZ
         iQddqRqcNSAwWsl6nqe8NPBbmkTpMkToYMXW2H1EaW6vIFhNBVlePPvw2HEupvTaOroS
         yKDHiQP8CFL7faFFm+8CQg9gjAzrL3VZ7Mzgk5plnHmgz2W4FmndNxFRITfpCyXd6dso
         Xsw6MS+H1qNnxNw6yrKZ8cbJm6t7oUvlKMsHCOX4lKigwsBla79XdAnEAz3EuhyWCEpw
         rOEQ==
X-Gm-Message-State: AOAM530cnSUreJprAf5PrsTLCLTJz/uUtNzZH1d/paPGXjidpdv/nQgV
        WNzijR9Zvy1/nTV5nzOX9QFxCaSvhMlmnBCsvnVnJWLdmF1MtqU/sXVUezY4r1Mikbl2wKGq8jy
        ivVnqwq+Bb5Gq19U1FwCvLCXR
X-Received: by 2002:a17:907:7e96:b0:6da:f7ee:4a25 with SMTP id qb22-20020a1709077e9600b006daf7ee4a25mr4174288ejc.436.1648107560845;
        Thu, 24 Mar 2022 00:39:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyB4biCBrcPL9gKQvLvT/ULJgefYHh1wmqJtXbE2bRdN6Ru88VKldaGAXNfrtmHkIVSMVNoFA==
X-Received: by 2002:a17:907:7e96:b0:6da:f7ee:4a25 with SMTP id qb22-20020a1709077e9600b006daf7ee4a25mr4174277ejc.436.1648107560680;
        Thu, 24 Mar 2022 00:39:20 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:cdb2:2781:c55:5db0? (2001-1c00-0c1e-bf00-cdb2-2781-0c55-5db0.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:cdb2:2781:c55:5db0])
        by smtp.gmail.com with ESMTPSA id r16-20020a056402019000b00418ed60c332sm1018992edv.65.2022.03.24.00.39.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 00:39:20 -0700 (PDT)
Message-ID: <2f33bdce-a002-708a-dd65-7bfb6ebc4cd9@redhat.com>
Date:   Thu, 24 Mar 2022 08:39:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: linux-next: build warnings after merge of the drivers-x86 tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Gross <markgross@kernel.org>
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220301201659.45ac94cd@canb.auug.org.au>
 <20220324183329.22c97ea1@canb.auug.org.au>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220324183329.22c97ea1@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/24/22 08:33, Stephen Rothwell wrote:
> Hi all,
> 
> On Tue, 1 Mar 2022 20:16:59 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> After merging the drivers-x86 tree, today's linux-next build (htmldocs)
>> produced these warnings:
>>
>> Documentation/ABI/testing/sysfs-driver-intel_sdsi:2: WARNING: Unexpected indentation.
>> Documentation/ABI/testing/sysfs-driver-intel_sdsi:2: WARNING: Block quote ends without a blank line; unexpected unindent.
>> Documentation/ABI/testing/sysfs-driver-intel_sdsi:2: WARNING: Definition list ends without a blank line; unexpected unindent.
>>
>> Introduced by commit
>>
>>   2546c6000430 ("platform/x86: Add Intel Software Defined Silicon driver")
> 
> I am still seeing these warnings.

I replied to your original report on March 1st, but I never got a reply
to my reply:

"""
Thank you for the report.

So I just did:

touch Documentation/ABI/testing/sysfs-driver-intel_sdsi
make htmldocs &> log

In a repo with drivers-x86/for-next checked out and checked the generated log files.
But I'm not seeing these WARNINGs.

Also 'find Documentation/output/ -name "*sdsi*"' does not output anything,
is there anything special (maybe some extra utilities?) which I need to also enable
building of htmldocs for the files in Documentation/ABI ?
"""

If someone can let me know how to reproduce these warnings I would be happy
to fix them.

Regards,

Hans

