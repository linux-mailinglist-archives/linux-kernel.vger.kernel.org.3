Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94B0506F13
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 15:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbiDSNtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 09:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352818AbiDSNrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 09:47:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E251C393F8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 06:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650375712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4adwg8hqyIITyJy5pTSFAx9A6BPYS26atLWx7A9LjPk=;
        b=HAfNlYPBJVU1n11d39HCAlDOdOwoQY2cFUuTOPPHjrBONyn2++PVLrGizvV4CL7yeBUcYM
        2LPcWyirKwnY3VnqVO4rfgz3YamsXJ3UTGyCCWbiEwqYnL5AvqEcVYA58KyRR+2gGRTs19
        5+ry1N/5B7KsYePsWizphCWJB1vdlpY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-278-flcKIT3CPwmra1Qpkovq4g-1; Tue, 19 Apr 2022 09:41:51 -0400
X-MC-Unique: flcKIT3CPwmra1Qpkovq4g-1
Received: by mail-wm1-f69.google.com with SMTP id bh11-20020a05600c3d0b00b003928fe7ba07so1241851wmb.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 06:41:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=4adwg8hqyIITyJy5pTSFAx9A6BPYS26atLWx7A9LjPk=;
        b=4glhh5R21YPxxQR3PoR04QfBhHG/EONXJwLDWnHVsUaCmWxkjboRLnLHlDsWDqHpRD
         sK5lNPw25BHg/f92wrgZEhULL9bBTi3+JBah7s+55iIUV4FTmeo+WnCm/WqAWzrsV16b
         bMV5AsdGwaF5O4xYMjQC8y3gcSRK2DGM6lE2BuLgh+de1ehCxBZ+qs/0wP32GyD+Rg+V
         N4wc7ZxBro3bum/96O15WgipIkWvnSoE14lKkTu0snI51cIU+h2szNoI8rQodJdIQBbV
         lgpiolRNZl2FBoxCQX/DxO9xdaTStbiyag0IvUWFI08UXVv1ro68bxI4kYHtgHrzK/PP
         Rp5g==
X-Gm-Message-State: AOAM530AY6ZQaU7LNnspz8O34hG29W8wCGYGzB4KawAQWj60qTrwYcOK
        0AY0rZ76HG3hl71ZpnC5qniPNAe6xCIQ2RScrN8DV8rddDX6I8aTunljCGsetJOOU+V3lj1qXjV
        OJcTXbTFLjyR07rx510uoLRo0
X-Received: by 2002:a05:600c:1c1f:b0:38e:c425:5b1a with SMTP id j31-20020a05600c1c1f00b0038ec4255b1amr16136726wms.69.1650375706941;
        Tue, 19 Apr 2022 06:41:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJvuZb+R54rr0s1wGva1v/Xk2FzPsygVQ3HcW3SsZOhzm7AK+wn4DeO9p0yN2bc4xhS4J72A==
X-Received: by 2002:a05:600c:1c1f:b0:38e:c425:5b1a with SMTP id j31-20020a05600c1c1f00b0038ec4255b1amr16136712wms.69.1650375706746;
        Tue, 19 Apr 2022 06:41:46 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-96-237.dyn.eolo.it. [146.241.96.237])
        by smtp.gmail.com with ESMTPSA id i27-20020a1c541b000000b003928e866d32sm9069716wmb.37.2022.04.19.06.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 06:41:46 -0700 (PDT)
Message-ID: <f6335341633b8af9bcbc1d410b2e6ae1b864c4e3.camel@redhat.com>
Subject: Re: [PATCH] net: ax88179: add proper error handling of usb read
 errors
From:   Paolo Abeni <pabeni@redhat.com>
To:     David Kahurani <k.kahurani@gmail.com>, netdev@vger.kernel.org
Cc:     syzbot+d3dbdf31fbe9d8f5f311@syzkaller.appspotmail.com,
        davem@davemloft.net, jgg@ziepe.ca, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        phil@philpotter.co.uk, syzkaller-bugs@googlegroups.com,
        arnd@arndb.de, dan.carpenter@oracle.com
Date:   Tue, 19 Apr 2022 15:41:45 +0200
In-Reply-To: <20220416074817.571160-1-k.kahurani@gmail.com>
References: <20220416074817.571160-1-k.kahurani@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-04-16 at 10:48 +0300, David Kahurani wrote:
> Reads that are lesser than the requested size lead to uninit-value bugs.
> In this particular case a variable which was supposed to be initialized
> after a read is left uninitialized after a partial read.
> 
> Qualify such reads as errors and handle them correctly and while at it
> convert the reader functions to return zero on success for easier error
> handling.
> 
> Fixes: e2ca90c276e1 ("ax88179_178a: ASIX AX88179_178A USB 3.0/2.0 to
> gigabit ethernet adapter driver")

In the next version, please additionally fix the above tag: it must use
a single line, even if that means exceeding the 72 chars length limit.

Thanks!

Paolo

