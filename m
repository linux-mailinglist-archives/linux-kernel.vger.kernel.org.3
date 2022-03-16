Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0C24DB3CA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 15:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356919AbiCPO5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 10:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346464AbiCPO5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 10:57:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0961366ACE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 07:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647442587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=voZ1TowISuZDmUgM/T0ZeaglCupBmFtGBGvPfwVeUQc=;
        b=YJRMzq+UZ4b7YzpleyF5WNsSmKCk2iCCHMBkCKdxD+NIV0Oerp2hS2xGgPape2ABkHK0QH
        RsavEtqAEqFh03xLxRHGy+VSuZynWo+YS2BUT0KsbRigcXYiZMq7RXUE3n8p5SCI/zn9e0
        x9EDHOWT1hzDIpQCXOWXG3S+EFVhZeI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-AXOy3bDOOdCaev_wHzw4IA-1; Wed, 16 Mar 2022 10:56:26 -0400
X-MC-Unique: AXOy3bDOOdCaev_wHzw4IA-1
Received: by mail-wr1-f72.google.com with SMTP id f14-20020adfc98e000000b001e8593b40b0so644700wrh.14
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 07:56:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=voZ1TowISuZDmUgM/T0ZeaglCupBmFtGBGvPfwVeUQc=;
        b=EOWFFj26F1USmV56Lig7gjJTG9OnJMS3K5yr4pgdd7zKvjrNk7Gvz0b2Sir1FGRBuj
         EUT2WbJrCxWc074vag3O61V81n1Eo5+cHIaH80eHxEQplvMZu/sDTiTYgNxePgQUj/Qd
         aS2toQFilRw0rNQSyVWdtthygDGTA5WWp3PtTLdeyfhhUqbF0GEahGXx2WSEmNGdLgyh
         B9Ywy/1NaUppzwDQrDsEv+L00fi7L27sv/Mc4kSLf3azq1Dz2i44tdppgSzzbboHJ5QF
         W+9GnStDoyv1wWFJbc4eEniuwCiO7C7S7uS0LVL3KEymNV1cfAHLrBejTl+lSidxwbMc
         w/Pg==
X-Gm-Message-State: AOAM531LJFwyQ7BB+Ga/3EX6jwP4adDz/N64SnpjUS07HFLtZzohZseu
        ZADC2WqlNPFYr+BwRCuqTsO3pEleykUDJf6lwNV8jugXIeaF3aqnr09ScZIJO1CY1NdVJMD0ELK
        5Hk2VPXjjww3KRNrjLHMKwJfg
X-Received: by 2002:a05:600c:500e:b0:38c:6d79:d5ac with SMTP id n14-20020a05600c500e00b0038c6d79d5acmr3017383wmr.42.1647442584519;
        Wed, 16 Mar 2022 07:56:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjIytKLVQ3f6gh/t2S1K26foAiH1BL5IwghKgUgeVEUI+0OpFvcs+A7kDilujtp46WA7cWbg==
X-Received: by 2002:a05:600c:500e:b0:38c:6d79:d5ac with SMTP id n14-20020a05600c500e00b0038c6d79d5acmr3017362wmr.42.1647442584253;
        Wed, 16 Mar 2022 07:56:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:f900:aa79:cd25:e0:32d1? (p200300cbc706f900aa79cd2500e032d1.dip0.t-ipconnect.de. [2003:cb:c706:f900:aa79:cd25:e0:32d1])
        by smtp.gmail.com with ESMTPSA id y13-20020adffa4d000000b00203e3ca2701sm737891wrr.45.2022.03.16.07.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 07:56:23 -0700 (PDT)
Message-ID: <412dc01c-8829-eac2-52c7-3f704dbb5a98@redhat.com>
Date:   Wed, 16 Mar 2022 15:56:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] delayacct: track delays from ksm cow
Content-Language: en-US
To:     cgel.zte@gmail.com, bsingharora@gmail.com,
        akpm@linux-foundation.org
Cc:     yang.yang29@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20220316133420.2131707-1-yang.yang29@zte.com.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220316133420.2131707-1-yang.yang29@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.03.22 14:34, cgel.zte@gmail.com wrote:
> From: Yang Yang <yang.yang29@zte.com.cn>
> 
> Delay accounting does not track the delay of ksm cow.  When tasks
> have many ksm pages, it may spend a amount of time waiting for ksm
> cow.
> 
> To get the impact of tasks in ksm cow, measure the delay when ksm
> cow happens. This could help users to decide whether to user ksm
> or not.
> 
> Also update tools/accounting/getdelays.c:
> 
>     / # ./getdelays -dl -p 231
>     print delayacct stats ON
>     listen forever
>     PID     231
> 
>     CPU             count     real total  virtual total    delay total  delay average
>                      6247     1859000000     2154070021     1674255063          0.268ms
>     IO              count    delay total  delay average
>                         0              0              0ms
>     SWAP            count    delay total  delay average
>                         0              0              0ms
>     RECLAIM         count    delay total  delay average
>                         0              0              0ms
>     THRASHING       count    delay total  delay average
>                         0              0              0ms
>     KSM             count    delay total  delay average
>                      3635      271567604              0ms
> 

TBH I'm not sure how particularly helpful this is and if we want this.

[...]

>  	struct vm_area_struct *vma = vmf->vma;
> +	vm_fault_t ret = 0;
> +	bool delayacct = false;
>  
>  	if (userfaultfd_pte_wp(vma, *vmf->pte)) {
>  		pte_unmap_unlock(vmf->pte, vmf->ptl);
> @@ -3294,7 +3296,11 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>  		 *
>  		 * PageKsm() doesn't necessarily raise the page refcount.
>  		 */
> -		if (PageKsm(page) || page_count(page) > 3)
> +		if (PageKsm(page)) {
> +			delayacct = true;
> +			goto copy;
> +		}
> +		if (page_count(page) > 3)
>  			goto copy;
>  		if (!PageLRU(page))
>  			/*
> @@ -3308,7 +3314,12 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>  			goto copy;
>  		if (PageSwapCache(page))
>  			try_to_free_swap(page);
> -		if (PageKsm(page) || page_count(page) != 1) {
> +		if (PageKsm(page)) {
> +			delayacct = true;
> +			unlock_page(page);
> +			goto copy;
> +		}
> +		if (page_count(page) != 1) {
>  			unlock_page(page);
>  			goto copy;
>  		}
> @@ -3328,10 +3339,18 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>  	/*
>  	 * Ok, we need to copy. Oh, well..
>  	 */

Why not simply check for PageKsm() here? I dislike the added complexity
above.


-- 
Thanks,

David / dhildenb

