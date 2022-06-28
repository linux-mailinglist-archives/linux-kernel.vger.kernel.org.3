Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E50355F1AE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 00:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbiF1W6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 18:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbiF1W6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 18:58:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C10E1039
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 15:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656457090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mk+Xp685pb+8wj1J+aRICQE6iudgejxXblH+0Ia6Clo=;
        b=iUTS+K8cpB4d2UNAuBq40bHMfqGS1ea7ysffmw29NvxwLNY7hZUcoQGdXcGvKiC9ot1n4J
        bl1RFcGSQhMNt4BamGNfNQT+b/vcVQeXGauM3J5sON30f//0NtrJRm2ilTOo+hv2ujMrkm
        wWC2/lU2mjDw9zS09QZLSdirRD0ctSk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-148-5tu6Xj6pNlWG8fNxf3hxGQ-1; Tue, 28 Jun 2022 18:58:09 -0400
X-MC-Unique: 5tu6Xj6pNlWG8fNxf3hxGQ-1
Received: by mail-qv1-f70.google.com with SMTP id u18-20020a0cf1d2000000b00470427ccfa5so13693333qvl.18
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 15:58:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=Mk+Xp685pb+8wj1J+aRICQE6iudgejxXblH+0Ia6Clo=;
        b=e/0HjHwVUUQs4QfDp97+iLzTbHA/UTxdtYPBQEKLMvVKB78vy+/HMDu7heZK+9od+/
         jHoCJn5EGLdv5OCzfEkcNGy2QUSYZAATh2oNSw/LyDwuMkxvuCJ+JsPrVCdyJP8ZkHyJ
         +SWK/3+fxHvdraDCa3cPQWwbln32IFyHl7hcoslMZi9OPzQOh+crB3DhoP06Uu/tnIUi
         LfhASI7CuW/zFuhPXYeppzXvAwcKLZqVmedshBqxNb8UKYR1yOJIbRkIhJ32x3MYrlmw
         uHWX+epf/Bgw2zQ4GFPbifK7l7Ip55gIKFZU4Sojm1H9Fh4AZK1EsjpHxUkBs6WSkz32
         afMg==
X-Gm-Message-State: AJIora8ggYY12AN9QLI6D+z5pfHlrvUEBQyF3WislSAoYr+4osCzB3JH
        +HyPZpFcMwxWivD7V1MEwxRWmh6GEtA9CGLJUZ34H6Kt938/yg0fQDRsifp0kmnDwTeRf/84ijB
        rXsMXvdTvT6KjgjK3k5wdpr8r
X-Received: by 2002:a0c:fa8c:0:b0:470:3ec6:5ca3 with SMTP id o12-20020a0cfa8c000000b004703ec65ca3mr5569302qvn.8.1656457088693;
        Tue, 28 Jun 2022 15:58:08 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1skOCkhgAQmhe6pa0m0HvrhedXdhpGjYu863mW2kX+qeNH7RR6JpwYJKUCJjZCjgo0Vv5YXzw==
X-Received: by 2002:a0c:fa8c:0:b0:470:3ec6:5ca3 with SMTP id o12-20020a0cfa8c000000b004703ec65ca3mr5569288qvn.8.1656457088495;
        Tue, 28 Jun 2022 15:58:08 -0700 (PDT)
Received: from [192.168.8.138] ([141.154.49.182])
        by smtp.gmail.com with ESMTPSA id t19-20020a05622a01d300b00304f3e320f2sm10590118qtw.4.2022.06.28.15.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 15:58:07 -0700 (PDT)
Message-ID: <fb44d2a7c69ebcddcf25858b6540a4bfa1ecd09d.camel@redhat.com>
Subject: Re: [PATCH RESEND] drm: i915: fix a possible refcount leak in
 intel_dp_add_mst_connector()
From:   Lyude Paul <lyude@redhat.com>
To:     Hangyu Hua <hbh25y@gmail.com>, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        tvrtko.ursulin@linux.intel.com, airlied@linux.ie, daniel@ffwll.ch,
        ville.syrjala@linux.intel.com, jose.souza@intel.com,
        matthew.d.roper@intel.com, anshuman.gupta@intel.com,
        heying24@huawei.com, james.ausmus@intel.com
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 28 Jun 2022 18:58:06 -0400
In-Reply-To: <4119ed8c7ace96e1fa46b34fd9e8404828c3e57d.camel@redhat.com>
References: <20220624022813.10796-1-hbh25y@gmail.com>
         <4119ed8c7ace96e1fa46b34fd9e8404828c3e57d.camel@redhat.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ah-nevermind! Seems like someone already pushed this for you :)

On Tue, 2022-06-28 at 18:55 -0400, Lyude Paul wrote:
> Nice catch!
> 
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> 
> Will push to drm-intel-next
> 
> On Fri, 2022-06-24 at 10:28 +0800, Hangyu Hua wrote:
> > If drm_connector_init fails, intel_connector_free will be called to take
> > care of proper free. So it is necessary to drop the refcount of port
> > before intel_connector_free.
> > 
> > Fixes: 091a4f91942a ("drm/i915: Handle drm-layer errors in
> > intel_dp_add_mst_connector")
> > Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> > Reviewed-by: José Roberto de Souza <jose.souza@intel.com>
> > ---
> >  drivers/gpu/drm/i915/display/intel_dp_mst.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c
> > b/drivers/gpu/drm/i915/display/intel_dp_mst.c
> > index 061b277e5ce7..14d2a64193b2 100644
> > --- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
> > +++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
> > @@ -839,6 +839,7 @@ static struct drm_connector
> > *intel_dp_add_mst_connector(struct drm_dp_mst_topolo
> >         ret = drm_connector_init(dev, connector,
> > &intel_dp_mst_connector_funcs,
> >                                  DRM_MODE_CONNECTOR_DisplayPort);
> >         if (ret) {
> > +               drm_dp_mst_put_port_malloc(port);
> >                 intel_connector_free(intel_connector);
> >                 return NULL;
> >         }
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

