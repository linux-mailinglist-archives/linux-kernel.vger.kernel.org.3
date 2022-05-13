Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AE4526185
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 14:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380114AbiEMMBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 08:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241025AbiEMMBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 08:01:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A35B261627
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 05:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652443303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kMuS9axp/S5JrovKAIWREvlNH6wCw/grTwemnAu/UbE=;
        b=PVdzPCp8qK1agwFOFnf0nLqXcFipFZiBq/c5VWmpWPgP2bumtNy87JkIPlwUA8yWaSN4tD
        JuAhT+QFtGXkd0WsRiJoo5VDUHZZLUbS0Ml0XrXAANY5Mw1FUHt9F9poFgTFuZvSAXybCL
        apuDAzS8R0qMNmONMDQn0nY+a3VB6aA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-NAbscDRXPL6pjiw0omtQUA-1; Fri, 13 May 2022 08:01:40 -0400
X-MC-Unique: NAbscDRXPL6pjiw0omtQUA-1
Received: by mail-wm1-f71.google.com with SMTP id r186-20020a1c44c3000000b00393f52ed5ceso5864493wma.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 05:01:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=kMuS9axp/S5JrovKAIWREvlNH6wCw/grTwemnAu/UbE=;
        b=6MB0C7OrSNJ6OBxkHc0Ek3R9cDwCDVxG62mwMof1hARWsfZuBmFe7tiGD3lVG0enaz
         aNVo0YRSPsOF5vx3q87g9Yjii8QjuBGSGZhWxibhB2jSJbw4BIT1VMO44cVXsZrmGpwb
         FromFU7dLNqLzbi6Ei3+Li/OwrBj5/CbjPqWisewWWQATt95k+zgv/RkAaxdSXjWVpZG
         aU2ZOY5oIEr4lgLQdVgiQC+h12sevo0TWkNTdygH9OzJhhHA6d1caPSMZrSoXyIMUfov
         NH0stUjSXQHLzi0zml7ewbB+qyg+LFuFiidAyEht7FC0VsqkHKmZiLbOE/UiK2LvQERd
         RtZQ==
X-Gm-Message-State: AOAM532y+fqpNqr+WUQy32/k1p/uJLAEGrKYZXHC1c4atkj12tv9e4Fd
        lo2ySHSaChNLv8VmuAv0l58pAiRummwRdp+C3veUdeNGWlXe3+nRwcKvDcSADBHMPBJ1OxVBahp
        XVXWRf97xYZHsDshgyH2GhF2n
X-Received: by 2002:a05:6000:1acc:b0:20c:67ff:e8b7 with SMTP id i12-20020a0560001acc00b0020c67ffe8b7mr3758030wry.646.1652443299264;
        Fri, 13 May 2022 05:01:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3iu+fLxjvx03k3fgRG0H8YZ88vRiw9g1/+RlTF54e/ZgNgxCgGnGFWbZWPKImozRoYK5L1Q==
X-Received: by 2002:a05:6000:1acc:b0:20c:67ff:e8b7 with SMTP id i12-20020a0560001acc00b0020c67ffe8b7mr3758010wry.646.1652443299026;
        Fri, 13 May 2022 05:01:39 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:1306:2f00:be0e:91f7:c0a3:32f0? ([2a0c:5a80:1306:2f00:be0e:91f7:c0a3:32f0])
        by smtp.gmail.com with ESMTPSA id a4-20020a05600c348400b003942a244ec4sm2252962wmq.9.2022.05.13.05.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 05:01:38 -0700 (PDT)
Message-ID: <26094ae15d7d716b0e6d34020999c844da91dd8b.camel@redhat.com>
Subject: Re: [PATCH 3/6] mm/page_alloc: Split out buddy removal code from
 rmqueue into separate helper
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Date:   Fri, 13 May 2022 14:01:37 +0200
In-Reply-To: <20220512085043.5234-4-mgorman@techsingularity.net>
References: <20220512085043.5234-1-mgorman@techsingularity.net>
         <20220512085043.5234-4-mgorman@techsingularity.net>
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
> This is a preparation page to allow the buddy removal code to be
> reused
> in a later patch.
>=20
> No functional change.
>=20
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> Tested-by: Minchan Kim <minchan@kernel.org>
> Acked-by: Minchan Kim <minchan@kernel.org>
> ---

Reviewed-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>

Thanks,

--
Nicol=C3=A1s S=C3=A1enz

