Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA3D4D15B2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242565AbiCHLId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbiCHLIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:08:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF107BCA3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 03:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646737654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+pn0Gp2y98eJDXuA8y7deIirBU9DlxAAqoNDwwNiF2I=;
        b=HEWoJNxBjh1JFbB4T0BfJwHm0s79S9t41d+hJwXymIZVLA8QIx5ovnexcggdfhqpwj8zFv
        zcwh7eUzaaLMGVNFPjb9Bo7HgREhj/S9NfwZvGRWPhD0Rn2GvQ21ieoX3ULfHqaD0NZAA2
        caVWETfiN1prRc0DDDdr4+yInC7Ok3M=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-PCJQEQZPNcGxco74m9ksvw-1; Tue, 08 Mar 2022 06:07:32 -0500
X-MC-Unique: PCJQEQZPNcGxco74m9ksvw-1
Received: by mail-ej1-f69.google.com with SMTP id k16-20020a17090632d000b006ae1cdb0f07so8500122ejk.16
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 03:07:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+pn0Gp2y98eJDXuA8y7deIirBU9DlxAAqoNDwwNiF2I=;
        b=ROIx5UXao/x2sb1SxJXwWul79ZdoBcLwUsYG1wC0BuUK6PAox2/QHprN3zPQwDYeSF
         JLj0fNVBshbepl2LB8pVOLugmxlnITTTxojoE5j+nAAWqsbJKb1+g5pkrCLDcvX6feR9
         bVRJL6s5mGbKeW8C1oqRA8puQAh2j69GgGlWTc8frMJW3ogbjrTFF/Vk73pO1MOtdGEt
         zjb6+UUXGpwqLhdceTRCCYv/xONSyGR6cjBTXZpsdNQbXQo8l74p8+w8Jvdn31zHXPs1
         79bsdUU5f4J4Qjbv52rWjXq4REmg5cDgwIiM8B/Jaw9TCvRTZRETGBSBQFiWDd8UNIUd
         r2qg==
X-Gm-Message-State: AOAM531bjYBbRGBRzykqLeoBs5YKCu2rvLBGm9Tzz+U+cT0Inq+23WYN
        4TPeXnDtNIYFPdtqXu5TC/C/EU3HJXrtNPAKAiPi1tsinNEh1U6cPWGAVcjC6DwzHxxm5Xk1Dwu
        erumNKbqeIXa1ZLaTgzfMFbWa
X-Received: by 2002:a17:907:6d1d:b0:6d8:9fc8:b1e1 with SMTP id sa29-20020a1709076d1d00b006d89fc8b1e1mr12410551ejc.466.1646737650940;
        Tue, 08 Mar 2022 03:07:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxesTWxnr9yva5EqLXO5ZOYMLukOGg2mvmb/yiXq/BaIek5yrIlr+WBV842eb0PxoGVnYMIYQ==
X-Received: by 2002:a17:907:6d1d:b0:6d8:9fc8:b1e1 with SMTP id sa29-20020a1709076d1d00b006d89fc8b1e1mr12410534ejc.466.1646737650745;
        Tue, 08 Mar 2022 03:07:30 -0800 (PST)
Received: from redhat.com ([2.55.138.228])
        by smtp.gmail.com with ESMTPSA id e12-20020a056402190c00b0041615cd434csm5336300edz.60.2022.03.08.03.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 03:07:30 -0800 (PST)
Date:   Tue, 8 Mar 2022 06:07:26 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     jasowang@redhat.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, stable@vger.kernel.org,
        syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
Message-ID: <20220308060705-mutt-send-email-mst@kernel.org>
References: <20220307191757.3177139-1-lee.jones@linaro.org>
 <20220307173439-mutt-send-email-mst@kernel.org>
 <YicNXOlH8al/Rlk3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YicNXOlH8al/Rlk3@google.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 08:01:32AM +0000, Lee Jones wrote:
> On Mon, 07 Mar 2022, Michael S. Tsirkin wrote:
> 
> > On Mon, Mar 07, 2022 at 07:17:57PM +0000, Lee Jones wrote:
> > > vhost_vsock_handle_tx_kick() already holds the mutex during its call
> > > to vhost_get_vq_desc().  All we have to do here is take the same lock
> > > during virtqueue clean-up and we mitigate the reported issues.
> > 
> > Pls just basically copy the code comment here. this is just confuses.
> > 
> > > Also WARN() as a precautionary measure.  The purpose of this is to
> > > capture possible future race conditions which may pop up over time.
> > > 
> > > Link: https://syzkaller.appspot.com/bug?extid=279432d30d825e63ba00
> > 
> > And this is a bug we already fixed, right?
> 
> Well, this was the bug I set out to fix.
> 
> I didn't know your patch was in flight at the time.
> 
> > > Cc: <stable@vger.kernel.org>
> > > Reported-by: syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com
> > 
> > not really applicable anymore ...
> 
> I can remove these if it helps.

yes let's do that pls.

> -- 
> Lee Jones [李琼斯]
> Principal Technical Lead - Developer Services
> Linaro.org │ Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog

