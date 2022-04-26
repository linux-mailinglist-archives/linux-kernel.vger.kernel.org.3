Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CB650FAE1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349222AbiDZKgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349169AbiDZKgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:36:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C83BD1A39C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 03:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650968339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gkDdSCTbv+qaqOfXuZFTV1kMMzXue7okd2ASSZDnojI=;
        b=SBE7mTCZ8wflp+Fb8zCp53YgHYds9R3wZtVD0skKztMcdFJW3mIP4EX4oWC16xYquPKBkf
        lz+Qp6aXy2w/pJnMTynceubIFAkvjpugHHnmzpmLrZXqftouaBugzTxjWEGtbXGqW7mf0s
        6s9hqxkoNQzmb2lz729qJvqVGHoFxio=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-483-FMrLaG1HMWORpCz4myvbZQ-1; Tue, 26 Apr 2022 06:18:57 -0400
X-MC-Unique: FMrLaG1HMWORpCz4myvbZQ-1
Received: by mail-wr1-f71.google.com with SMTP id g7-20020adfbc87000000b0020ac76d254bso2969781wrh.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 03:18:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=gkDdSCTbv+qaqOfXuZFTV1kMMzXue7okd2ASSZDnojI=;
        b=A0IsJkPpat44IV47LWGJGYRYJOSepbDbZyKkKIYuW0v0MMBlN9YTQwTmSd2bIZM4uy
         861WLX99gqm5KSemYVlZ2xnxlsj9CX78WiRuXVPlh6DVgEZhENlpVYoHJwzn1buSh+W8
         dmOVUOSzM+G9h9SlG9LLvVe7qn7a4h10dze+nPr9Yn9Oy3CFX44M0qecWtg8+sVtH/Ro
         zTHXFg93G/WmsdHhVBsqxtkrpverJyM4Hi1mzJ3MKBNP45LpYMiu3HxWznfknABcF2h9
         p5tFZQhorAruM8rbxqMRRDjINrQxKyx6WvmX/u7G22XTpewScIniotSXcPN9RmRieSq4
         rFig==
X-Gm-Message-State: AOAM532gZTpn2CBlR1uPejUVqIttHaDoWe/jDUa+EP1xZTYWAMn1zH4+
        UDUBy3PfBenCywrhQ8izuUfLwUnuvki5+40bPTeuZkgyDhvX9kjHC4pS7/KDdHNiittAtczBUi4
        Mfcn1rXUJ/DKv31h4Pc6qf9AW
X-Received: by 2002:a5d:584e:0:b0:20a:9122:2c3c with SMTP id i14-20020a5d584e000000b0020a91222c3cmr17720155wrf.193.1650968336572;
        Tue, 26 Apr 2022 03:18:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyoNazsV0I15fxm/4/Pfpd5hXMjXY+YOXnqJlw6z1+2bYI1a+azURcsXOvUCb6LtTGCyY3GmQ==
X-Received: by 2002:a5d:584e:0:b0:20a:9122:2c3c with SMTP id i14-20020a5d584e000000b0020a91222c3cmr17720138wrf.193.1650968336373;
        Tue, 26 Apr 2022 03:18:56 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:1306:2f00:cfcf:62cf:6f38:dd92? ([2a0c:5a80:1306:2f00:cfcf:62cf:6f38:dd92])
        by smtp.gmail.com with ESMTPSA id g3-20020a5d64e3000000b0020aaa0fea8bsm11311776wri.49.2022.04.26.03.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 03:18:55 -0700 (PDT)
Message-ID: <06e0138a526f1fd9fe5b18184163c1ff98f0103b.camel@redhat.com>
Subject: Re: [PATCH v9 0/6] Raspberry Pi Sense HAT driver
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Charles Mirabile <cmirabil@redhat.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Mattias Brugger <mbrugger@suse.com>,
        linux-rpi-kernel@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        fedora-rpi@googlegroups.com, Daniel Bauman <dbauman@redhat.com>,
        Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
Date:   Tue, 26 Apr 2022 12:18:55 +0200
In-Reply-To: <CABe3_aE-nQzZazLfxk1OnCNRF0sDqcWi6gieYSf4O4aYS_Ahog@mail.gmail.com>
References: <20220419205158.28088-1-cmirabil@redhat.com>
         <CANiq72n1gBE+tv3oAF4wjdK2jEJJmU4V=Y1CTZ1PpCEeqLbo9g@mail.gmail.com>
         <CABe3_aE-nQzZazLfxk1OnCNRF0sDqcWi6gieYSf4O4aYS_Ahog@mail.gmail.com>
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

Hi Charles, Miguel,

On Mon, 2022-04-25 at 19:34 -0400, Charles Mirabile wrote:
> Hi Miguel—
> 
> Thanks for your help in reviewing this patch. I think all of the feedback is cleared up.
> 
> I am not sure which tree this should go into, but maybe the Raspberry Pi tree maintained
> by Nicolas Saenz Julienne (git://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-
> rpi.git)? What do you think? Thanks!

Since there is no code dependency between the different drivers/patches I
suggest for each patch to go through its respective maintainer tree. Also, if
we were to move the whole series through as single tree, it's important to have
ACKs from all the subsystem maintainers.

I'll do a last review during the week.

Regards,

-- 
Nicolás Sáenz

