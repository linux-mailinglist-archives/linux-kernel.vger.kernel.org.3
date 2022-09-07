Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CEA5AFE21
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 09:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiIGHwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 03:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiIGHvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 03:51:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CE04DB0C
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 00:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662537106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8KMdampSVOfSjQJ+eYUB/+euJ05288b13jRxouoL8v4=;
        b=IezB9TYvDSRE7d8eZ3U7LmS9k+++6Su6DYFT/ukOl65iDNDtBdlFUnSmEqGeCU2OSfoU3E
        XCwgT4FDBAG7M6wNdP8Dc8S6vojhoHhhmb43n2RiL5zSxwF8qMrIrWhM9t5yp9lTk10m7n
        jAkW/NjoHwuiehTqKUn8Yzjr8BdJfrk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-135-gXIHg-3AO6yD1fZTlcCn7Q-1; Wed, 07 Sep 2022 03:51:45 -0400
X-MC-Unique: gXIHg-3AO6yD1fZTlcCn7Q-1
Received: by mail-wr1-f72.google.com with SMTP id e15-20020adf9bcf000000b002285faa9bd4so2761745wrc.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 00:51:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=8KMdampSVOfSjQJ+eYUB/+euJ05288b13jRxouoL8v4=;
        b=xTb/Z2XzhKGkSvbXCU8j/tDO39frYx3QQBOtSlw2oBc2A6vNyvp6mwN7Ld71SAksKE
         NI0nl2asEopnx7crivH4xj5ElboAEtVbAP+Y1nA5aIQ6J/iB1QFQzckbcca+DGAoT4ih
         KqMwWDO/Vo3rVoKjY87nP1GjNA+ky2RP57Hn8nzqDGGs4BH38OVmVnSxXP45DLtfONbG
         s9k+Y4JlUnr0iSKnErzekm3JpXgpHlvVI5aYCTKhY8M7ze0nCwowxXIiOgz5rZRWzxBY
         WipIWaWpLBlQT6XPMYchSEazLqewDbMS5z4HVm1RUxgtvOMbsKmeQpxWy6smv+sO5X6C
         FYzA==
X-Gm-Message-State: ACgBeo3IDW0aAHw8kaMHAbPLwybWj8Lpx7oqSReoI75rH9Y524vQ0Sjh
        WtbfnqShJ0rLn6A0AqDpkmKFm98trs1RaxiDCGlHKoRNmF78EXXJ/Wl3BCIqsWO/ej0HSV5Tsq6
        gnd6kCK/+H8KzWzQ6tJQCIGlx
X-Received: by 2002:a5d:6f19:0:b0:228:d8e8:3ac8 with SMTP id ay25-20020a5d6f19000000b00228d8e83ac8mr1149254wrb.101.1662537103860;
        Wed, 07 Sep 2022 00:51:43 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6ThqBf88YF8iut0HC9FOIofHwvY/fghW1g6YgYSZwxQVisX9JDtm6hidIgh47utu42naZpeA==
X-Received: by 2002:a5d:6f19:0:b0:228:d8e8:3ac8 with SMTP id ay25-20020a5d6f19000000b00228d8e83ac8mr1149243wrb.101.1662537103667;
        Wed, 07 Sep 2022 00:51:43 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-69.retail.telecomitalia.it. [87.11.6.69])
        by smtp.gmail.com with ESMTPSA id d14-20020adff2ce000000b00228d6edade0sm6597943wrp.46.2022.09.07.00.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 00:51:43 -0700 (PDT)
Date:   Wed, 7 Sep 2022 09:51:38 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     vdasa@vmware.com
Cc:     vbhakta@vmware.com, namit@vmware.com, bryantan@vmware.com,
        zackr@vmware.com, linux-graphics-maintainer@vmware.com,
        doshir@vmware.com, gregkh@linuxfoundation.org, davem@davemloft.net,
        pv-drivers@vmware.com, joe@perches.com, netdev@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 0/3] MAINTAINERS: Update entries for some VMware drivers
Message-ID: <20220907075138.ph3bbitnev72rei3@sgarzare-redhat>
References: <20220906172722.19862-1-vdasa@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220906172722.19862-1-vdasa@vmware.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 10:27:19AM -0700, vdasa@vmware.com wrote:
>From: Vishnu Dasa <vdasa@vmware.com>
>
>This series updates a few existing maintainer entries for VMware
>supported drivers and adds a new entry for vsock vmci transport
>driver.
>

Since you are updating MAINTAINERS, what about adding 
"include/linux/vmw_vmci*" under "VMWARE VMCI DRIVER"?

Thanks,
Stefano

