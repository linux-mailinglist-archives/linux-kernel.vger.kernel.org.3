Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7387453536F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 20:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244864AbiEZShi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 14:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345254AbiEZShZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 14:37:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 380DF694A5
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 11:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653590243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iZXZyOBj9K/G+WFDwIrle6dO9n3UzwXZHEEzIr/nzYk=;
        b=EcN/9lvQ2vCfiG/e2xYWoODYOQEkXUaYtUvRX8268CA1WFkXVfs8Auaql9IoYONSvGMBJ2
        6mBRqFgpr/pG17PrvReBn5zLlg5IX/OcoO4i8GXSCQbuDVXT7FP6pM8DtGv6bu6c+vKTFY
        TgD6/kjuAvbgplcnNHYCZRAbPn5ChMU=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-302-Ml5Y1yKDO720KnabuZbwxg-1; Thu, 26 May 2022 14:37:22 -0400
X-MC-Unique: Ml5Y1yKDO720KnabuZbwxg-1
Received: by mail-io1-f70.google.com with SMTP id k184-20020a6bbac1000000b0065aeedd4ba8so1472312iof.20
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 11:37:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iZXZyOBj9K/G+WFDwIrle6dO9n3UzwXZHEEzIr/nzYk=;
        b=Qqc7th9LrvUPICPzvNwR8R2tpBP5etMFRS+IplhNBP5NBPNVWfocC/Hce1ccK9SgMu
         kJOACcj9Y4nGCqsbTaAJf2/6tgSSAm8LluYColEfVSkKJTVCiA7LjxrbnTHDXBJ43+s8
         2iV4v4miIpjareF11+2Hbfkpah5tb3jxcJ8vCZ6umn8MfGJJocKW0BWrDkQ1atWvXR+z
         qAc8Z2z6s30Vp3BY/MdF0Ak4+UImmkEzSTm1NOms2/FehaNY/SZ6hT4fB5zbijFWfe//
         pzJVxugxQoZR/zrcchEZzRD5dl+AWkvP4HxZ3uyNhUrv3vuwHJcUC2uICzl6WvGWMiod
         Q44Q==
X-Gm-Message-State: AOAM5305A+Wr0v+YB8fO1aSt8gemj83Y3zb8fEzer3DRA/mm1In0PGYF
        SA+NDyin8YeEULrr9IyJyeCoJPAeT/DfX+VUc49VDzmYCQkcM8pdzmqPH1GVnbfUfE5/Sje7JPz
        jzDLPFYLAgY+s8Evas2OxtlTG
X-Received: by 2002:a05:6638:4901:b0:32f:d52c:924c with SMTP id cx1-20020a056638490100b0032fd52c924cmr6248112jab.8.1653590241277;
        Thu, 26 May 2022 11:37:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpP2TSvS6e9NpQEMUP3qCECYxWtAnkzb4ugRqwUnJ/Y/Oan//xTqCMVr3HgbEkayorckxxRg==
X-Received: by 2002:a05:6638:4901:b0:32f:d52c:924c with SMTP id cx1-20020a056638490100b0032fd52c924cmr6248102jab.8.1653590241044;
        Thu, 26 May 2022 11:37:21 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id x89-20020a0294e2000000b0032e43cb7344sm575684jah.146.2022.05.26.11.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 11:37:20 -0700 (PDT)
Date:   Thu, 26 May 2022 14:37:18 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jue Wang <juew@google.com>
Cc:     pizhenwei@bytedance.com, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, jasowang@redhat.com,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, mst@redhat.com,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>, Paolo Bonzini <pbonzini@redhat.com>,
        qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 0/3] recover hardware corrupted page by virtio balloon
Message-ID: <Yo/I3oLkd9OU0ice@xz-m1.local>
References: <CAPcxDJ5pduUyMA0rf+-aTjK_2eBvig05UTiTptX1nVkWE-_g8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPcxDJ5pduUyMA0rf+-aTjK_2eBvig05UTiTptX1nVkWE-_g8w@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 01:16:34PM -0700, Jue Wang wrote:
> The hypervisor _must_ emulate poisons identified in guest physical
> address space (could be transported from the source VM), this is to
> prevent silent data corruption in the guest. With a paravirtual
> approach like this patch series, the hypervisor can clear some of the
> poisoned HVAs knowing for certain that the guest OS has isolated the
> poisoned page. I wonder how much value it provides to the guest if the
> guest and workload are _not_ in a pressing need for the extra KB/MB
> worth of memory.

I'm curious the same on how unpoisoning could help here.  The reasoning
behind would be great material to be mentioned in the next cover letter.

Shouldn't we consider migrating serious workloads off the host already
where there's a sign of more severe hardware issues, instead?

Thanks,

-- 
Peter Xu

