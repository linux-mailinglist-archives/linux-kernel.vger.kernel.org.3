Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731C95065E5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 09:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349399AbiDSHc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 03:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349404AbiDSHcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 03:32:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9562329B1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650353373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qvQQnX3WJ1O+c8AM33EECNVK+BAhJ0ReCydNRlwYc0w=;
        b=SoQp0oeGKRWtUPo0LM2dtI85P41Gnuk9R1ZUKHXqeWXgglYZqkLaYA0VDkKiz+JERhDzSv
        jZyXlvkAtcP/kSJp6vnKmATyR5XltA1t+YcwYlhfa0OJgPBUVKUU65sQnlkDyuXt8N5Gi3
        aZTzIuKDJfmVv0h0OGOcLlpKBGo5064=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-X3FjeeuHPI-91d4eLuTIGg-1; Tue, 19 Apr 2022 03:29:32 -0400
X-MC-Unique: X3FjeeuHPI-91d4eLuTIGg-1
Received: by mail-wm1-f69.google.com with SMTP id r9-20020a1c4409000000b0038ff033b654so736097wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=qvQQnX3WJ1O+c8AM33EECNVK+BAhJ0ReCydNRlwYc0w=;
        b=L34vshr8KagfKmBpjxYxdvD9qltT8BrAdFWTBSGjLSk1yYr14iEofeZBH/3jrA+Vo7
         rafnbaZGn+Q9gf9LVfFR0UxvoNxXGpDPnI+zawxHPGzQj3glUBDdHFi6YNQZdpTp5lAh
         M3RIdHYSPbgXzNP9bXAOpyWLfrcWJ0C/tLOAV9oly8dqUEXHdLBvr4aQRJ+yAKdA7apa
         K0SXtuT6BAJrSHp1MXG0XNLgEalhgfVWGPNaWvzfa1K7UVzKkdgtyOrpLqYd5b664sM1
         NVwueHEQNgbgZdEHRF5Ah/0X5pPDl/8y9Q3W43tx7V1UHlGm9NbPJwxHadXNAw+gu+1+
         x8zw==
X-Gm-Message-State: AOAM532NpX+ZeFehy+Eb9rjlFFoZC685YAOK0P9imtrCL2xVFW7siqwE
        Ih4t0kE5UyGWMQVn0ijhOMGx1iEqsBJhacdnNtDHk1Q3j4KxLff3NtfSLNdVBwjL1ZxKPfZZLmC
        f9iHCMqCj97TqthLjUbO2S8ly
X-Received: by 2002:a05:600c:206:b0:38e:b6b4:a2d6 with SMTP id 6-20020a05600c020600b0038eb6b4a2d6mr14574504wmi.156.1650353371115;
        Tue, 19 Apr 2022 00:29:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5Pu8g2po/QIskvpzd7OvuvOxSUOCn0SycUJ5J0RTseeEDBVjkgZR3umgRDnf8T3fQmpCg6Q==
X-Received: by 2002:a05:600c:206:b0:38e:b6b4:a2d6 with SMTP id 6-20020a05600c020600b0038eb6b4a2d6mr14574496wmi.156.1650353370939;
        Tue, 19 Apr 2022 00:29:30 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-96-237.dyn.eolo.it. [146.241.96.237])
        by smtp.gmail.com with ESMTPSA id g8-20020a05600c4ec800b0039290a5b827sm7990169wmq.24.2022.04.19.00.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 00:29:30 -0700 (PDT)
Message-ID: <5f5be1321b5ba6b721f9d0aab563d36133328d33.camel@redhat.com>
Subject: Re: [PATCH net-next v2] sungem: Prepare cleanup of powerpc's
 asm/prom.h
From:   Paolo Abeni <pabeni@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date:   Tue, 19 Apr 2022 09:29:29 +0200
In-Reply-To: <11d54e799ff339f9d4aa00a741dc1e04755db7a7.1650012142.git.christophe.leroy@csgroup.eu>
References: <11d54e799ff339f9d4aa00a741dc1e04755db7a7.1650012142.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, 2022-04-15 at 10:43 +0200, Christophe Leroy wrote:
> powerpc's asm/prom.h brings some headers that it doesn't
> need itself.
> 
> In order to clean it up in a further step, first clean all
> files that include asm/prom.h
> 
> Some files don't need asm/prom.h at all. For those ones,
> just remove inclusion of asm/prom.h
> 
> Some files don't need any of the items provided by asm/prom.h,
> but need some of the headers included by asm/prom.h. For those
> ones, add the needed headers that are brought by asm/prom.h at
> the moment, then remove asm/prom.h
> 
> Some files really need asm/prom.h but also need some of the
> headers included by asm/prom.h. For those one, leave asm/prom.h
> but also add the needed headers so that they can be removed
> from asm/prom.h in a later step.

This commit message is a little confusing, as this patch covers only a
single case of the above. I suggest to replace re-phrase the commit
message to be more specific. You could also explcitly mention which
symbols from linux/of.h sungem_phy.c needs, if the list is short.

Thanks,

Paolo

