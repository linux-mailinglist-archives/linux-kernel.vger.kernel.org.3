Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6B94EDA66
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 15:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236756AbiCaNWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 09:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbiCaNWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 09:22:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2BB441DB894
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 06:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648732829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WBWds1AFP5e86H9VKQpRJJb3wuQBpqPKJ0Gs8NSPHjo=;
        b=BbcJEgPKXXfgTnNtW07fjunguV+qUAuHnWAMLxdwLRjFYIQUucw6nEr8SWzRWrnUL7YQ3z
        L5d0ZDx4svN676pTpPVmJPJJ2t9kLGWo6+S++PEANO3necJZPcFTQZF+da67DmzVT4AAyI
        AGqFgkmikezqE/zCtj8Tb1O+xKxQkWE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-O1mLqRKuOoaulSLIVcdKrg-1; Thu, 31 Mar 2022 09:20:27 -0400
X-MC-Unique: O1mLqRKuOoaulSLIVcdKrg-1
Received: by mail-wr1-f71.google.com with SMTP id k20-20020adfc714000000b001e305cd1597so6472293wrg.19
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 06:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=WBWds1AFP5e86H9VKQpRJJb3wuQBpqPKJ0Gs8NSPHjo=;
        b=oZ4GlrXzvsOhDEYTUusBwWIOo29TWwzCiWZFxAKPa0JXE19/wvokP+KETpPDKQZjGL
         XiG1dQrF/OuAadYzRdt5kbDhdsdWOyx/CuEXNOa8MUMRHsQESX4RjhTZhDnAvbjPR9rU
         SzHuoDkq76r/2nH9/tuu6mJ4McVWKLPfLJq0HKw/4rRezfYJlsKz6ENHPC6lgaG6W8V6
         DZTkGKnct9VpnLY0NkUznlJUQJZU+HJsdZY6Ky57prwXMh5tVzgsF5HKB1m41Ne93iMn
         k5WQsia/bj+AoLgTOyZhvJWOfGRt5DwGvDgqdAlOEd3FuqZEi9ldEhcml/gpOk2LElSY
         O5Fw==
X-Gm-Message-State: AOAM531QLm9KxB+LSqbb3JSY0vqWjXE9a5m3ohaw5IJdRxqxGvdn8kVL
        n5CzqJqXPBKwiersCfOZJ+9IosxoimxSkx3Vd+OF6x73qpUkv9plmlSiDiZBI3GMccEXQPe5nK/
        gflzjPQN7SclxcLx6qBjkZErc
X-Received: by 2002:a1c:7302:0:b0:381:1f9a:a22b with SMTP id d2-20020a1c7302000000b003811f9aa22bmr4643881wmb.78.1648732826546;
        Thu, 31 Mar 2022 06:20:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9hovXTozfht/ACofvvbzrXrjDiD1Bgs2ETCfJDxgcy2Qkpd++tzM6xL/tWDeJHCVl32/18Q==
X-Received: by 2002:a1c:7302:0:b0:381:1f9a:a22b with SMTP id d2-20020a1c7302000000b003811f9aa22bmr4643857wmb.78.1648732826250;
        Thu, 31 Mar 2022 06:20:26 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-243-142.dyn.eolo.it. [146.241.243.142])
        by smtp.gmail.com with ESMTPSA id c8-20020a056000184800b002040e925afasm23990873wri.59.2022.03.31.06.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 06:20:25 -0700 (PDT)
Message-ID: <78917523440153533f0b5aad533a96d0f7c27916.camel@redhat.com>
Subject: Re: [PATCH net] rxrpc: fix some null-ptr-deref bugs in server_key.c
From:   Paolo Abeni <pabeni@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org,
        Xiaolong Huang <butterflyhuangxx@gmail.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Thu, 31 Mar 2022 15:20:24 +0200
In-Reply-To: <3114597.1648729013@warthog.procyon.org.uk>
References: <4de651adc35341c5fa99db54b9295d4845648563.camel@redhat.com>
         <164865013439.2941502.8966285221215590921.stgit@warthog.procyon.org.uk>
         <3114597.1648729013@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-03-31 at 13:16 +0100, David Howells wrote:
> Paolo Abeni <pabeni@redhat.com> wrote:
> 
> > It looks like we can add a couple of fixes tag to help stable teams:
> > 
> > Fixes: d5953f6543b5 ("rxrpc: Allow security classes to give more info on server keys")
> 
> Not this one.  This includes a check for the one op it adds:
> 
> 	+       if (sec && sec->describe_server_key)
> 	+               sec->describe_server_key(key, m);
> 
> 
> > Fixes: 12da59fcab5a ("xrpc: Hand server key parsing off to the security class")
> 
> There's a missing 'r' in "rxrpc:" in the patch subject, but otherwise this one
> looks like the right one.

Thank you for double-checking. No need to repost, I'll add the tag
while applying it.

Cheeers,

Paolo

