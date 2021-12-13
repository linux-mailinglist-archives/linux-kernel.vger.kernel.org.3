Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5D0472B60
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235857AbhLML35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:29:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58708 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232670AbhLML34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:29:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639394995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Df9Tat+4TSgT6S/fwEMHt15xbYoMBqAg+q9c1eSZfms=;
        b=VjPZpFXs7mk48nqTY5WHRgp6zSTt5UwHAl2iyQOog2e7qfGdSuR9omSvYFeBp6A5IRjfXv
        s0Nuim03EqQ4TLCASZqW4ZrC2v11gX/kibCucg3+t7QJp4Rbp7anzG4m/QrgUZspcB5IGa
        +OmxY4d0drnfGweIMkdwhQe8vYGn4KE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-348--pKMfms5MGenRLj4byyygw-1; Mon, 13 Dec 2021 06:29:54 -0500
X-MC-Unique: -pKMfms5MGenRLj4byyygw-1
Received: by mail-wm1-f72.google.com with SMTP id i131-20020a1c3b89000000b00337f92384e0so11450607wma.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 03:29:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Df9Tat+4TSgT6S/fwEMHt15xbYoMBqAg+q9c1eSZfms=;
        b=BsunB/slVGjRRu0nl+27GfX8lRzx8D+0oU6LJE3n5EL6cfW+0FtTD+BPBj9bYk34HJ
         F6IEebjuLsYTFPnLQDRCN2/qoxfbkG478DRHydXoxGLoHN8QCYb8rw1fM5ajBSVwPjqU
         5KyrSUvc+U8xc9EpkK6OWCIzN9hSvyf/FjQ46+JmbhaLkVI5KuTlgYtFjVX4MirWWsJP
         jkWyC2klc0HNPZee+hdHNYEUXvz7fwVpGReyGxi/99RDo0bQi8hWFb7K6C3j+XgjV8Id
         Wp1HpUUHM3zICKLwpcL5PGyd25YAFSy/Zmvh6mrG2y3oXPd6XW7zjh21+zO41f0Zoq9O
         BptQ==
X-Gm-Message-State: AOAM531HJtNGyMlO56YU/Meqt9UaNb1Eph+e1elpSOGoHzGpOqk4LjDk
        HXLq/2Dph/CUKLso8ArbG76veVDEjVkBiq8fB30rH0XZpWdzG2+JsYWPSbpX7WuZyd5Mv8CXv6v
        OBmMVUsJHq7102FfQlFmP1wnK
X-Received: by 2002:a05:600c:22cb:: with SMTP id 11mr36815439wmg.181.1639394993441;
        Mon, 13 Dec 2021 03:29:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyYQAgdhC5J25RBuK59xz9lLpTDiKgFvyhm+adfnvXJK7kC0BwK92jX9kXvntzY014xStyU0Q==
X-Received: by 2002:a05:600c:22cb:: with SMTP id 11mr36815412wmg.181.1639394993204;
        Mon, 13 Dec 2021 03:29:53 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:3c10:3400:3c70:6643:6e71:7eae? ([2a0c:5a80:3c10:3400:3c70:6643:6e71:7eae])
        by smtp.gmail.com with ESMTPSA id q24sm6693855wmj.21.2021.12.13.03.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 03:29:53 -0800 (PST)
Message-ID: <ff321353fa27a156a0eab9cc9674dfad760f22a8.camel@redhat.com>
Subject: Re: [PATCH V5 0/6] Raspberry Pi Sense HAT driver
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Charles Mirabile <cmirabil@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Mattias Brugger <mbrugger@suse.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
Date:   Mon, 13 Dec 2021 12:29:52 +0100
In-Reply-To: <20211210221033.912430-1-cmirabil@redhat.com>
References: <20211210221033.912430-1-cmirabil@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charles, Thanks for iterating on this.

On Fri, 2021-12-10 at 17:10 -0500, Charles Mirabile wrote:
> Suggestions from v4 not addressed yet:
> 	- Use mfd_cells for the joystick and display platform devices
> 	  (as suggested by Matthias Brugger) or remove sensehat-core.c
> 	  entirely and use simple-mfd-i2c instead (as suggested by
> 	  Nicolás Sáenz Julienne).
> 	  	- while these suggestions might make great improvements
> 	  	  for a version two of the driver they would require a
> 	  	  large rewrite to move all of the complexity in core
> 	  	  elsewhere. While certainly possible and something
> 	  	  we want to iterate on and achieve eventually, we
> 	  	  think saving it for down the road makes sense at this
> 	  	  time.

Sorry for insisting, but I'm not convinced by this approach. The way you design
your driver affects its devicetree bindings, once we settle on those any
upgrade will have to be backwards compatible (i.e. an old DT would have to work
with the new implementation). This makes changing this further down the road
unlikely.

In terms of complexity, most of it is there due to not using the APIs and
facilities the mfd subsystem provides. See my comments in the driver.

Regards,

-- 
Nicolás Sáenz

