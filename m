Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947AC592C2A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242095AbiHOJn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 05:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbiHOJn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 05:43:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C98891EAE2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 02:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660556606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FQOUTS80HcZiERMDGmDJApodo1j0CVdPfRMkvjW6yzY=;
        b=VRFEUIWbq4cKrqmyxCUrKgiy31gD7AS7IVXDmqpO+SuIhIOFI6BdMIIyKLEjZEGWau6Qar
        dxySlQ2pun2dqi3f6lZbEKNYFvZLBaPSbii2BwtUC4X2frw0JsPPW1uGNYP2B7hEcLIZhO
        WMlt0pfD/nZHFnBacO+NZwfMaeqCi4o=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-517-5nYc0maTN72kVU6qKCSKEA-1; Mon, 15 Aug 2022 05:43:24 -0400
X-MC-Unique: 5nYc0maTN72kVU6qKCSKEA-1
Received: by mail-ed1-f69.google.com with SMTP id q18-20020a056402519200b0043dd2ff50feso4419435edd.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 02:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=FQOUTS80HcZiERMDGmDJApodo1j0CVdPfRMkvjW6yzY=;
        b=RHvKQB61nx3HzScK/ZW6mcJfiKcEjQL0AoPXhMKfYEzBw7s0weAJfZe3AmYQpStiQm
         QJYmk401T4vrmWmevdzwwEQ3qC1MS7jiQpjEuSjOVmkh7OMUl/olXTXp2ZCB33GTQq4p
         20OxgtShx9HvVWTrzlrecg0DMsOalFgSCO9iRAykg7Er19ojCK5kDxd2ykMiifBKuj+z
         JZTidXhmikPzgUIJ/F+YeHvcDhk1lTlhYk5AA+HGrpMNzWynfB/WfBU8bkoW7SKldAgn
         I87tPwzXBfiDmqja8GUL38UcwmXLZmGB8V7bIzeFwktYrV0hUKyqRja2ddvtT5xdpSvz
         PWCw==
X-Gm-Message-State: ACgBeo0wpwdRz9h/T0QraqEeVsPPykxeaKP4SopLeEEfz87wCMMXpkD6
        09Tc3gmKwLAOnALn4axERg3MYAjMH335/mc2SquNMfhneKWJnH9fUsooV9N+xmp/6QeFa8xFfZs
        49NRlQDMbhfjIvv7FZKUa0uts
X-Received: by 2002:a05:6402:3506:b0:43e:954b:bc8a with SMTP id b6-20020a056402350600b0043e954bbc8amr14220063edd.266.1660556603283;
        Mon, 15 Aug 2022 02:43:23 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4dZtsSaRr3BCotU+lOGZMYhjH0zBr8qOJ26Q22OdX1qtkhhmkvzHqqJQdyvWrI2LG5tPO00Q==
X-Received: by 2002:a05:6402:3506:b0:43e:954b:bc8a with SMTP id b6-20020a056402350600b0043e954bbc8amr14220048edd.266.1660556603021;
        Mon, 15 Aug 2022 02:43:23 -0700 (PDT)
Received: from redhat.com ([2.54.169.49])
        by smtp.gmail.com with ESMTPSA id n6-20020aa7c686000000b0043d34ab7ad6sm6333009edq.49.2022.08.15.02.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 02:43:22 -0700 (PDT)
Date:   Mon, 15 Aug 2022 05:43:19 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: upstream kernel crashes
Message-ID: <20220815054117-mutt-send-email-mst@kernel.org>
References: <20220814212610.GA3690074@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220814212610.GA3690074@roeck-us.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2022 at 02:26:10PM -0700, Guenter Roeck wrote:
> Hi all,
> 
> syscaller reports lots of crashes with the mainline kernel. The latest
> I have seen, based on the current ToT, is attached. Backtraces are not
> always the same, but this one is typical.
> 
> I have not tried to analyze this further.
> 
> Guenter

Thanks a lot for the report!

Could you please try the latest vhost tree:
https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next

which has been reported by Andres Freund to fix a similar issue?

Thanks!

-- 
MST

