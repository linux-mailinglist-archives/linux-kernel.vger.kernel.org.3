Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6ED659E4D3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 16:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241921AbiHWOEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 10:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242560AbiHWOAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 10:00:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BEA23A4AD
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 04:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661252814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9vFwWtlaXBJfhkm+20Q4BimLsKsx1b4GpBGhXdNHVUg=;
        b=UgHO9k/cLIFkdC9FQMzGD5E0HrriR51EyG7NjOj5ufDT2F0ZreGbnXbFaoYZhYBCWZJF6Y
        y4k6PIoj5xfFj0JpOg0kjVuDJ/31h4yU3TaRAIfRHrvjHxysCBfoiiFx2J6Bec9mGgp7ya
        SQoQHElxC9ybaTuB/CCh+DOnVQ/JnXk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-584-PWv75rylNQiZ-c4OAsANWA-1; Tue, 23 Aug 2022 07:06:53 -0400
X-MC-Unique: PWv75rylNQiZ-c4OAsANWA-1
Received: by mail-wm1-f70.google.com with SMTP id n7-20020a1c2707000000b003a638356355so5607058wmn.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 04:06:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=9vFwWtlaXBJfhkm+20Q4BimLsKsx1b4GpBGhXdNHVUg=;
        b=eb459yDQSHbgOe4nu0YxidogYVBc6AtDyxCAEjzV+I2iro0DAxLis2fw56wBxp8Iw5
         qmVdsMiFOkpfLwKZYY8p+R6HqDdOMcCC+/yerlxwM0yP5gyWLL99ix7Mw+I8JxzSt2Xi
         AZkAa7IVvJXXaftcBPcvrai63/gSBk8bFV8Gpt61iYaR3to0UJ/OvpMOJfCM0H76+1jA
         iYK7rERVRHJhoGhzrASOMQhw5QVSc1waQ/6vgrON4OsYf5YMb9K+PnxIKw39k7SAOWkt
         IIpfnDVo65PTmkAbvLP9We85YFDa+/KabUkzTAFKONPo4qCdN0bnPQtYcGHf1rwmaXkR
         wMiw==
X-Gm-Message-State: ACgBeo1TQqbJfcVxU6sPHARURGml0MGm0boIB4B41g9TCYNGJFEuyR74
        H/dNSUvUV8gtlCy3MzM3B3IM2bAiDOF9kPZFcEWfE7WyxprdmE96yOlibqXecgnAz9X5qgk1F8v
        WOJiU2yABl5UCO5BhUN2dn4Sp
X-Received: by 2002:a05:600c:384f:b0:3a6:603c:4338 with SMTP id s15-20020a05600c384f00b003a6603c4338mr1822491wmr.192.1661252811619;
        Tue, 23 Aug 2022 04:06:51 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5DCT0OQblrn5cXEd8HIrkGgjZmmi8yFbjusnd23J8AN0pMS1n6Obdq1k352nw99irqcnP1SQ==
X-Received: by 2002:a05:600c:384f:b0:3a6:603c:4338 with SMTP id s15-20020a05600c384f00b003a6603c4338mr1822481wmr.192.1661252811386;
        Tue, 23 Aug 2022 04:06:51 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-176.dyn.eolo.it. [146.241.97.176])
        by smtp.gmail.com with ESMTPSA id i6-20020a5d4386000000b0022159d92004sm8043071wrq.82.2022.08.23.04.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 04:06:50 -0700 (PDT)
Message-ID: <6e47d3d9f8cc73c6baf26d2b5f320d51f67d9a04.camel@redhat.com>
Subject: Re: [kernel PATCH v2 1/1] Bluetooth: hci_sync: hold hdev->lock when
 cleanup hci_conn
From:   Paolo Abeni <pabeni@redhat.com>
To:     Zhengping Jiang <jiangzp@google.com>,
        linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date:   Tue, 23 Aug 2022 13:06:49 +0200
In-Reply-To: <20220822214430.kernel.v2.1.I1d10fc551cadae988dcf2fc66ad8c9eec2d7026b@changeid>
References: <20220823044434.3402413-1-jiangzp@google.com>
         <20220822214430.kernel.v2.1.I1d10fc551cadae988dcf2fc66ad8c9eec2d7026b@changeid>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-08-22 at 21:44 -0700, Zhengping Jiang wrote:
> When disconnecting all devices, hci_conn_failed is used to cleanup
> hci_conn object when the hci_conn object cannot be aborted.
> The function hci_conn_failed requires the caller holds hdev->lock.
> 
> Fixes: 9b3628d79b46f ("Bluetooth: hci_sync: Cleanup hci_conn if it cannot be aborted")
> 
> Signed-off-by: Zhengping Jiang <jiangzp@google.com>

For the records, you should avoid empty lines between the 'fixes' tag
and your SoB.

Cheers,

Paolo

