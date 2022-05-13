Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3829526188
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 14:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380130AbiEMMDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 08:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380127AbiEMMDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 08:03:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 903F861627
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 05:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652443391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=InGhDMkcup0GagnASVzgx+dKX2knJzd1xQg5+9fN/y4=;
        b=PvoRaUmp6VwZf9xb7R2ECWfuBUD9rruivi/DkXLe9R1V6VkCWZ5LsVJqZYSD2JKhODSG+P
        WJvNb87LAavHnUbidtLJluDQbN2vMJX2H0QoIP9bLlxTpL9aTbqpbe/hY8dgaJ2R1KZfgP
        Q2I/xk41bxzpRuIDTCR+HPk1FLqwTTI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-PD7TkWPcOqiQJ1MogSbNkw-1; Fri, 13 May 2022 08:03:10 -0400
X-MC-Unique: PD7TkWPcOqiQJ1MogSbNkw-1
Received: by mail-wm1-f71.google.com with SMTP id p24-20020a1c5458000000b003945d2ffc6eso2847055wmi.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 05:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=InGhDMkcup0GagnASVzgx+dKX2knJzd1xQg5+9fN/y4=;
        b=qGwjBP+ryA0EUL1DBJSNbLUnDyoJAfck2AkLAd50e95T0wl+NZe9oNZG8V0fF5GixW
         jQieMc0e2xMliRfrI3rUQCWE1KysMJtxoatAdE2FvCoSH7qr8vyjrumV7W+y6djfaCSN
         K313VBkDzoZ4kSo4903U0d2Qtrv5iXkEqxMnTSp7okYoq8shqbz0eRxyxCu//XVaVLCT
         na3+twbeK4SF/AUAX/j3odjmK8Iu7txTa4PffDoxEPkdaz53udq4J2EuD7HIBCT3kYAh
         tjgqaa4fn0cVqj3Cqr4sfZ1dGtyetjRUDIFPMbHBKeXnY5jcRCBR6v+O/gHFxO2BMdmR
         AoHg==
X-Gm-Message-State: AOAM531KWL76cxxPV8aboFya5KS1X3aEc5whwkM0E4Po2YzC7X98XVhh
        GuSUHcjzyapQnt4OR+F+2xJjwrgS1WfLscX+QjftOgSLhzM2Sa1ITP0oO0xSPzIRAa3NfjnxQVz
        HPKgSjVy9kiDAC0+vpAihQm2K
X-Received: by 2002:adf:e94d:0:b0:20c:d4d3:c696 with SMTP id m13-20020adfe94d000000b0020cd4d3c696mr3731607wrn.136.1652443389468;
        Fri, 13 May 2022 05:03:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzi5XYqp/fTB48DqoJAA1/Ye79XxuoHvTUDaKgK304p8SKf1INMxAgcZ+nWWo/NwbkFCpqHCw==
X-Received: by 2002:adf:e94d:0:b0:20c:d4d3:c696 with SMTP id m13-20020adfe94d000000b0020cd4d3c696mr3731585wrn.136.1652443389232;
        Fri, 13 May 2022 05:03:09 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:1306:2f00:be0e:91f7:c0a3:32f0? ([2a0c:5a80:1306:2f00:be0e:91f7:c0a3:32f0])
        by smtp.gmail.com with ESMTPSA id l12-20020adfbd8c000000b0020c547f75easm1940208wrh.101.2022.05.13.05.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 05:03:08 -0700 (PDT)
Message-ID: <55aaf618497e7d0d369f773723b12e5dcfbdd27d.camel@redhat.com>
Subject: Re: [PATCH 4/6] mm/page_alloc: Remove unnecessary page == NULL
 check in rmqueue
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Date:   Fri, 13 May 2022 14:03:08 +0200
In-Reply-To: <20220512085043.5234-5-mgorman@techsingularity.net>
References: <20220512085043.5234-1-mgorman@techsingularity.net>
         <20220512085043.5234-5-mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1 (3.44.1-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-05-12 at 09:50 +0100, Mel Gorman wrote:
> The VM_BUG_ON check for a valid page can be avoided with a simple
> change in the flow. The ZONE_BOOSTED_WATERMARK is unlikely in general
> and even more unlikely if the page allocation failed so mark the
> branch unlikely.
>=20
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> Tested-by: Minchan Kim <minchan@kernel.org>
> Acked-by: Minchan Kim <minchan@kernel.org>
> ---

Reviewed-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>

Thanks,

--=20
Nicol=C3=A1s S=C3=A1enz

