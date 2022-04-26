Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6015105EB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 19:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353631AbiDZRtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 13:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349209AbiDZRtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 13:49:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2CFE1B2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 10:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650995201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UyHFMRMYec8pKum11uE5p2KKdtxqjNqZDXrySSGMmcw=;
        b=eaJJu+cH1LhrvdsUd6l4PMQgDjtu//NEJ+n2xzhqI+G9O61JkHhtl3ZdKFoz9AFoXrX5AL
        svfkXEKfFKywIUMT6lRDQppRmVOMMp6eydji1sNXHWClsb5hEx0TkR3WoishbE/mycJazm
        DA+/pkukmp+71dLoyNwIJhAOSuwP1j4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-287-Xj8dtYGiPSqzgRj-WKVNFw-1; Tue, 26 Apr 2022 13:46:40 -0400
X-MC-Unique: Xj8dtYGiPSqzgRj-WKVNFw-1
Received: by mail-qk1-f199.google.com with SMTP id bk23-20020a05620a1a1700b0067b32f93b90so12176972qkb.16
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 10:46:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=UyHFMRMYec8pKum11uE5p2KKdtxqjNqZDXrySSGMmcw=;
        b=2SlVEZHxZi+q0zQgIZ+YcJLEj2rYlTtZiqTFn6L4GfQIFynds6lemL3bNKO8M0nDx+
         eLboczd7rb0ytuvj9hddTTJuDlLINpqWl7F39aUknSLcfWZlXtloB6sQoqHBIhv1+7l5
         6kq9Jx8itmSsEoT3goWW4+u/5GSo8Gzah5TOjSfuFpXDk7uKP/PHC7N54tmdQv7Y5GYt
         fseOFqwWEM113Lenm9ezIoCXLnk52ueiQa1d9U3BmOBYM6jKIONBHWnxoIlahZkX+y+k
         NJe+5eWKtb4Kvw+KuQsx3HD4R0BZBxeH7zauE8wVtMHcfNlwWdKl6atjIEcD2wj1PM1a
         RQAA==
X-Gm-Message-State: AOAM531R0cT4s090m0Shp0Nku4GVw5hGUF5s95A1oHwLfYsAJvmlhI6H
        hVeCzWxd9QrYWIJjOhQlIloyfif6L1XydB15uvPtx+jcYllv2Ev9vA5le14ofpW2VpnzNQDsKsB
        pSU871CyCh6GCdONR9aTSQtgh
X-Received: by 2002:a05:6214:c4d:b0:449:7011:56d0 with SMTP id r13-20020a0562140c4d00b00449701156d0mr17055885qvj.70.1650995199257;
        Tue, 26 Apr 2022 10:46:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytQo4guo50H9GZxl1ELWFz7ma3vpp9ula5MxUUZOqiIR/U1tsZlJzmD9Gpb2jw0WaPhaKbqg==
X-Received: by 2002:a05:6214:c4d:b0:449:7011:56d0 with SMTP id r13-20020a0562140c4d00b00449701156d0mr17055867qvj.70.1650995199030;
        Tue, 26 Apr 2022 10:46:39 -0700 (PDT)
Received: from [192.168.8.138] (static-71-184-137-158.bstnma.ftas.verizon.net. [71.184.137.158])
        by smtp.gmail.com with ESMTPSA id v7-20020a379307000000b0069c0a2afc55sm6966783qkd.123.2022.04.26.10.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 10:46:38 -0700 (PDT)
Message-ID: <1c11c3b9647829e197fb262c4afb66739fc7eca4.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/disp/gv100: make gv100_disp_wimm static
From:   Lyude Paul <lyude@redhat.com>
To:     Tom Rix <trix@redhat.com>, bskeggs@redhat.com, kherbst@redhat.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 26 Apr 2022 13:46:37 -0400
In-Reply-To: <20220425130050.1643103-1-trix@redhat.com>
References: <20220425130050.1643103-1-trix@redhat.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push upstream in a moment

On Mon, 2022-04-25 at 09:00 -0400, Tom Rix wrote:
> Sparse reports this issue
> wimmgv100.c:39:1: warning: symbol 'gv100_disp_wimm' was not declared. Should
> it be static?
> 
> This variable is only used in wimmgv100.c.  Single file variables should be
> static.
> So use static as its storage-class specifier.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/engine/disp/wimmgv100.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/wimmgv100.c
> b/drivers/gpu/drm/nouveau/nvkm/engine/disp/wimmgv100.c
> index 89d783368b4f..bb4db6351ddf 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/wimmgv100.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/wimmgv100.c
> @@ -35,7 +35,7 @@ gv100_disp_wimm_intr(struct nv50_disp_chan *chan, bool en)
>         nvkm_mask(device, 0x611da8, mask, data);
>  }
>  
> -const struct nv50_disp_chan_func
> +static const struct nv50_disp_chan_func
>  gv100_disp_wimm = {
>         .init = gv100_disp_dmac_init,
>         .fini = gv100_disp_dmac_fini,

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

