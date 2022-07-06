Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83370567B30
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 02:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiGFA64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 20:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiGFA6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 20:58:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E01DABE23
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 17:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657069130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L/VIshmF4xT9wjWGvPNSfMhdl0xNY9tpFrPyWnO0aT8=;
        b=MrhlrfP5fRa1E5mfCJ5Hqtoe/R1qhj4eR67rODbwOqgwgWRAzJOZ5T2+uxZoQM2CYt2dmR
        n4D3HYIWn2ViyZfWVf7X5kx8kxcYoXVtIlw8Y+ldFkfGdsrrnf2IbjtyG6KTI7tQxFkC6V
        DniXJKXJkb7ZU7RMn1WeyEp0Wx9uvdg=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-ApjZan9yNXOSPzA9hV9qAQ-1; Tue, 05 Jul 2022 20:58:49 -0400
X-MC-Unique: ApjZan9yNXOSPzA9hV9qAQ-1
Received: by mail-pf1-f198.google.com with SMTP id cg26-20020a056a00291a00b005289a87cf4fso816754pfb.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 17:58:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=L/VIshmF4xT9wjWGvPNSfMhdl0xNY9tpFrPyWnO0aT8=;
        b=GG5rnbJVpWyQUIvXF4+33p1O6IdMQPdYZl1Fn3jQKnL2duG6xF+pUVnT+umubUdVAr
         DXRhZaEUhmqDoU7T+/V8wRAA+13h4y/5YjdWSExQg1GftZi+GxjFsQIrki5i9NHSFUdF
         U7iOYtpLfX7C/R7MXBxAJkqQGu1xJEoLHHm3QxBs6XQm/B3sW2l6MMZq8MNRWRW1XGbr
         PyHE9g1lf3mNTyeTCy0UOpZBj4I3KpcZuzFuBQW6M33oA12ZSfoWGCL4nKzr5iqnLeA3
         bcccNmWBdoCdmv+FRD6bWZ04YYsWoSkLM+Y8i9TwiQeSjVWx/7R6JVIrG7vVrjRO3USM
         SMJA==
X-Gm-Message-State: AJIora+us8CcvG2PLerEs2ftQp8KDHt1sY2XDnDA9xtFQCMmnMYf0pbV
        7LLcfz3A2r/dsOuXFCb0hQ0rxlJy4CCorxCpQWMvhziuK3l1qvLsA47RQNX9NX5KKjMuu1a4+S/
        uyuzEM6jLQ3fODMs8LaxiHOa/
X-Received: by 2002:a17:90a:e7c6:b0:1ef:9ab6:406e with SMTP id kb6-20020a17090ae7c600b001ef9ab6406emr7426869pjb.108.1657069128695;
        Tue, 05 Jul 2022 17:58:48 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1silTss9+EIoox09QHdHlVkmVoGOPWNKlZe23v0wKMWdZReT8feVbKNmYUOn6gMvpy4A5MnbA==
X-Received: by 2002:a17:90a:e7c6:b0:1ef:9ab6:406e with SMTP id kb6-20020a17090ae7c600b001ef9ab6406emr7426844pjb.108.1657069128474;
        Tue, 05 Jul 2022 17:58:48 -0700 (PDT)
Received: from [10.72.12.227] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id n13-20020a170903110d00b0016bec529f77sm3774563plh.272.2022.07.05.17.58.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 17:58:47 -0700 (PDT)
Subject: Re: [PATCH 1/2] netfs: release the folio lock and put the folio
 before retrying
To:     David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     idryomov@gmail.com, vshankar@redhat.com,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        willy@infradead.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com
References: <30a4bd0e19626f5fb30f19f0ae70fba2debb361a.camel@kernel.org>
 <20220701022947.10716-1-xiubli@redhat.com>
 <20220701022947.10716-2-xiubli@redhat.com>
 <2187946.1657027284@warthog.procyon.org.uk>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <8ce8c30f-8a33-87e7-1bdc-b73d5b933c85@redhat.com>
Date:   Wed, 6 Jul 2022 08:58:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <2187946.1657027284@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/5/22 9:21 PM, David Howells wrote:
> Jeff Layton <jlayton@kernel.org> wrote:
>
>> I don't know here... I think it might be better to just expect that when
>> this function returns an error that the folio has already been unlocked.
>> Doing it this way will mean that you will lock and unlock the folio a
>> second time for no reason.
> I seem to remember there was some reason you wanted the folio unlocking and
> putting.  I guess you need to drop the ref to flush it.
>
> Would it make sense for ->check_write_begin() to be passed a "struct folio
> **folio" rather than "struct folio *folio" and then the filesystem can clear
> *folio if it disposes of the page?

Yeah, this also sounds good to me.

-- Xiubo


> David
>

