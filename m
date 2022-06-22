Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FE65546CA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbiFVKtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 06:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbiFVKth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:49:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B30E3BA66
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 03:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655894975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QchBbQyipF458CAuLWLqnynSF1BJuncWmu+EGU0Vk4U=;
        b=hkOKIJeizbMkjQpAYtRPNKh+oC6n0p3fuKqkvQlI84FyjUx9rhIRwikWqFa2oHdTGBBXAK
        LeAv1qIpq4rmZ3sYxLXObrz8ghVNHGEsAO8qFHwTErR8Jvf9SrJR22tpNXCaPP8oGouHRT
        TbjOxh4pqwyTTfvGykvu5BHR2u3GnUM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-36-wsr3ly_uNBKGgGWCIMFXpQ-1; Wed, 22 Jun 2022 06:49:34 -0400
X-MC-Unique: wsr3ly_uNBKGgGWCIMFXpQ-1
Received: by mail-wm1-f72.google.com with SMTP id m22-20020a7bcb96000000b0039c4f6ade4dso5386175wmi.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 03:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=QchBbQyipF458CAuLWLqnynSF1BJuncWmu+EGU0Vk4U=;
        b=yZLkG4ePJuVoPhf8K6YrcOqiA4jLZmuicH6enXGiMIpq7wegvhlB8oSzYjseVbWsku
         zFKNC0IYeDcfTPsLhzljrdhqwDNoEDgsfzHZogvTdK2X0V1olN3knCU9JGN0wwTE2c/S
         Satuw1DRIqz8z3h5385iGfstwc1WSPepwuC57IGQNRBhXaTvklLUiiHSYrayEDacdOPM
         XrQ0RG8fVtFG/UfRUYvgpX9sIHZ3wuox8l6Y7AsBUn7GGQ6tg5Fi/XUxGos85h340D24
         YpyIkb2EVkapv9rczkJUcgcOSBp6W8Qieaen3XuKSzn9EgksdsGG0OzilFzMDFj6mmM+
         t8NQ==
X-Gm-Message-State: AJIora/OKNqaX/nK1jawTq+YVRdo9T0qK4QlRytV2qU4hsAlzY+s3+9r
        u+HfMzyEnkb/WvQPysfn7aKu0+eOXqAKHb+nYU2rgq+i2lv1TisoaXyb4NK3uiK6TtucgBSOwrh
        lLz4uCDg8zabDTMsqnk/OY/BO
X-Received: by 2002:adf:dc50:0:b0:21b:874e:e76a with SMTP id m16-20020adfdc50000000b0021b874ee76amr2733893wrj.169.1655894973256;
        Wed, 22 Jun 2022 03:49:33 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uzhmbY0XGICZUrcb13PNEQTwpr0zmZiFQY/BI8oFh9a0jlQrA0RaKNeL9TEIJwy3ecrc60rw==
X-Received: by 2002:adf:dc50:0:b0:21b:874e:e76a with SMTP id m16-20020adfdc50000000b0021b874ee76amr2733864wrj.169.1655894972986;
        Wed, 22 Jun 2022 03:49:32 -0700 (PDT)
Received: from ?IPV6:2003:cb:c703:5100:9c77:ce13:2aeb:8748? (p200300cbc70351009c77ce132aeb8748.dip0.t-ipconnect.de. [2003:cb:c703:5100:9c77:ce13:2aeb:8748])
        by smtp.gmail.com with ESMTPSA id g16-20020a05600c4ed000b003974860e15esm29565856wmq.40.2022.06.22.03.49.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 03:49:32 -0700 (PDT)
Message-ID: <f876efc4-56b8-0d10-2dae-4eacfaed7e43@redhat.com>
Date:   Wed, 22 Jun 2022 12:49:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 1/2] mm/page_alloc: Do not calculate node's total pages
 and memmap pages when empty
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220621041717.6355-1-osalvador@suse.de>
 <20220621041717.6355-2-osalvador@suse.de>
 <506203e3-1de0-1187-5234-7afc66d4ddfe@redhat.com>
 <YrKQyhwDwMvueOUc@localhost.localdomain>
 <YrKS6aFHKRyZzAwi@FVFYT0MHHV2J.usts.net>
 <bb71d77e-583a-d216-1aae-2bc062318888@redhat.com>
 <YrLY1ru0qrvZfqU2@FVFYT0MHHV2J.usts.net>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YrLY1ru0qrvZfqU2@FVFYT0MHHV2J.usts.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.06.22 10:54, Muchun Song wrote:
> On Wed, Jun 22, 2022 at 10:31:12AM +0200, David Hildenbrand wrote:
>> On 22.06.22 05:56, Muchun Song wrote:
>>> On Wed, Jun 22, 2022 at 05:47:22AM +0200, Oscar Salvador wrote:
>>>> On Tue, Jun 21, 2022 at 09:44:47AM +0200, David Hildenbrand wrote:
>>>>>
>>>>>
>>>>> It's worth noting that the check in pgdat_is_empty() is slightly
>>>>> different. I *think* it doesn't matter in practice, yet I wonder if we
>>>>> should simply fixup (currently unused) pgdat_is_empty().
>>>>
>>>> I guess we could change it to
>>>>
>>>>  static inline bool pgdat_is_empty(pg_data_t *pgdat)
>>>>  {
>>>> 	 return node_start_pfn(pgdat->node_id) == node_end_pfn(pgdat->node_id)
>>>>  }
>>>>
>>>> ? And maybe even rename it to to node_is_empty (not sure why but I tend to like
>>>
>>> At least I like this name (node_is_empty) as well.
>>>
>>
>> Let's try keeping it consistent. I think node_is_empty() might indicate
>> that we're punching in a node id instead of a pgdat.
>>
> 
> I suspect Oscar will change the argument to "nid" as well, like:
> 
> static inline bool node_is_empty(int nid)
> {
> 	return node_start_pfn(nid) == node_end_pfn(nid);
> }
> 
> Does this look good?

Then we have to lookup the pgdat multiple times for (IMHO) no real
compelling reason.


-- 
Thanks,

David / dhildenb

