Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C8354C46C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243934AbiFOJQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345533AbiFOJPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:15:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F79B3FBEF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 02:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655284535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3ihw/tQZ7dDGm/WIN83Xbht+igW1FpV/t8X/MIkfZfY=;
        b=IrrPBtXNe+3Qo08DOrwWmBxiyO6rigF0uSvDffdV/rnqsR/F8Axy/51ijQlVlwrZHWBkSz
        ocmlGK7UW8CIaKxH+nb857QXhgo7gafUYZpVvLtuIV6YNamKfOsV2rNGiAjyoeJr1/2qjN
        PN+UuDZ9FJSOOMeApTJfS4NrgCVLj7c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-271-g2AZKlJIM5OvI36s9-eqFA-1; Wed, 15 Jun 2022 05:15:33 -0400
X-MC-Unique: g2AZKlJIM5OvI36s9-eqFA-1
Received: by mail-wm1-f72.google.com with SMTP id j31-20020a05600c1c1f00b0039c481c4664so4834672wms.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 02:15:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=3ihw/tQZ7dDGm/WIN83Xbht+igW1FpV/t8X/MIkfZfY=;
        b=Lo6U+YCiqxwoK/L4lp2Qang84EakxvVuxr9W0KsOl0kMXyoQJnMb73Si5ejGj5emfq
         M9GURgCyyhsygQ5emWpIvlvfs2onvi81t+9MIg8p3ql791888+i6YABeBiFItu66pH+8
         McxmkuBgv1Z4SRXg+M/nuzHBSri3bsec6+pi0idsBCkplAnHDhzZnsj0D2IfDieXwah7
         Mc1Y7Aaq3X4Sifr2dqVFSqc9nr8Fc2wkO1yPvCMw4W98gokINrSgO6qpg3IbrHhI+nYf
         tdq8ec8mr0CNYSzSg9Ebr/yqPK4wuuDz2tD2JHpLBoyUDpgZVautEaG596LV7YRkZrsT
         XbCA==
X-Gm-Message-State: AJIora8AXtpe6UE55t2dR6yy51xYNyenqWG+rkfDLqV1jMMUGK28JlNl
        Json7MQkJYgvNSFnG9aBLt6C2Ihs2983A/CzKLSW8FWCDzF1hUJfluxtpDGYYuEd6gvxc9ent5w
        B06xKBahUMFW781fHrgAOppC/
X-Received: by 2002:a05:6000:1a88:b0:218:4e7f:279d with SMTP id f8-20020a0560001a8800b002184e7f279dmr8860289wry.670.1655284532499;
        Wed, 15 Jun 2022 02:15:32 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vsqXPRk9u33dyg66eh75muPwVuzV7/fWeHx+RGAoDtTJtfdtO8XKyNHzp5Sstm9f26pEFS3g==
X-Received: by 2002:a05:6000:1a88:b0:218:4e7f:279d with SMTP id f8-20020a0560001a8800b002184e7f279dmr8860267wry.670.1655284532176;
        Wed, 15 Jun 2022 02:15:32 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:2700:1d28:26c3:b272:fcc6? (p200300cbc70a27001d2826c3b272fcc6.dip0.t-ipconnect.de. [2003:cb:c70a:2700:1d28:26c3:b272:fcc6])
        by smtp.gmail.com with ESMTPSA id b2-20020a056000054200b0020c5253d8dcsm14055748wrf.40.2022.06.15.02.15.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 02:15:31 -0700 (PDT)
Message-ID: <16297304-82d9-f62b-b87f-cc8d8fde9bd4@redhat.com>
Date:   Wed, 15 Jun 2022 11:15:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v1] MAINTAINERS: add MEMORY HOT(UN)PLUG section and add
 myself as reviewer
Content-Language: en-US
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20220610101258.75738-1-david@redhat.com>
 <72194595-a177-088d-28a9-0a24d4192777@redhat.com>
 <20220614103842.af0c9a5434e3099cf9060cf5@linux-foundation.org>
 <YqlaE/LYHwB0gpaW@localhost.localdomain>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <YqlaE/LYHwB0gpaW@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.06.22 06:03, Oscar Salvador wrote:
> On Tue, Jun 14, 2022 at 10:38:42AM -0700, Andrew Morton wrote:
>> On Tue, 14 Jun 2022 08:58:55 +0200 David Hildenbrand <david@redhat.com> wrote:
>> um, fine, no opinion really.  I think the main thing is to make
>> get_maintainer.pl spit out all the suitable email addresses.
> 
> As already pointed out, David and I have already kind of acted as maintainers of
> this aready already for quite some time, reviewing and contributing the most, so
> it might make sense to just spell that out, so, without willing to step on
> anyone's toes, what about this:
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1fc9ead83d2a..f5a746624a9f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12857,6 +12857,18 @@ F:     include/linux/vmalloc.h
>  F:     mm/
>  F:     tools/testing/selftests/vm/
>  
> +MEMORY HOT(UN)PLUG
> +M:     David Hildenbrand <david@redhat.com>
> +M:     Oscar Salvador <osalvador@suse.de>
> +L:     linux-mm@kvack.org
> +S:     Maintained
> +F:     Documentation/admin-guide/mm/memory-hotplug.rst
> +F:     Documentation/core-api/memory-hotplug.rst
> +F:     drivers/base/memory.c
> +F:     include/linux/memory_hotplug.h
> +F:     mm/memory_hotplug.c
> +F:     tools/testing/selftests/memory-hotplug/

Fine with me to remove Andrew from that list because he's implicitly
covering most stuff via the "MEMORY MANAGEMENT" section.

@Andrew, whatever you prefer.

Acked-by: David Hildenbrand <david@redhat.com>


@Andrew, would it make sense to update the git tree in the "MEMORY
MANAGEMENT" section now that mm-stable etc. resides on git.kernel.org ?


-- 
Thanks,

David / dhildenb

