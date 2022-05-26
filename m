Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5E8535388
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 20:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244454AbiEZSqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 14:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348926AbiEZSpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 14:45:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E90E02E089
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 11:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653590753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ODmk396yYTmyZ0DEUNSD4vk11H4s6Zx2e3M7LfpgTu0=;
        b=PRV1v00PHpfZPq2NUOvz1qPIKfSwtJ+zd/VHv84aqCukq/ctrh8Tc9Qmx8GyGHN235fjUa
        rRgUA9cQnzBxPsba5vKZX3kKLKh2JgWvOct/ZKpc0OosgVW+TAFH2H9XqwPYAXx7vADnWC
        nYi/2Gchw93OJlkT+wj7YDMXWaHs2kI=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-LJzcqz87NdCcU3jlz1qEwA-1; Thu, 26 May 2022 14:45:51 -0400
X-MC-Unique: LJzcqz87NdCcU3jlz1qEwA-1
Received: by mail-io1-f69.google.com with SMTP id r188-20020a6b2bc5000000b0065fc8f23866so1484553ior.16
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 11:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ODmk396yYTmyZ0DEUNSD4vk11H4s6Zx2e3M7LfpgTu0=;
        b=aZX5yT3EGMB0K7AIpcT6Eci1xpJgzyNLxVUrQdxTOlHM0CYJ3rYyhmv83egUv8jvfp
         nrhFkqoRY8TXN6K4Kt+mGaU/1oPN1C8cfiBeKpCB2K2R5WNw+MGvtkZZrxCWthU4CLPx
         lpqfmoHQ6EK5vu6skgoiX3tFXJxN8DnLkNmTjGaBCIpy3Fsl6Tumbu4QilnvqXCADB3m
         xcveZkS/rNX/54tYaH7tSReBoosxr2ZBeFS5z49igrF/alREXhZBVwPp9mWlnAqlF1oR
         cuTgJIjqjZfur0bxvUs6bplvdLOxLS8Ffsw/HZ5czxydJRiM7GadUThC4+eAzhmALULs
         AeMw==
X-Gm-Message-State: AOAM530BNgIA0RN85x/4S805hqsucRobRIcKGze4MKvGPy+K/yc5LVJy
        desEQ8fmbH+SX9vNGGZYxlcVc85CxYGIXl3Y4v6AhW7viOSxMYijMvCsJ2vBoiJaZtLehI4PnU+
        wjoznS1TAeyZ1WmkWKzt4bwld
X-Received: by 2002:a05:6638:1482:b0:32e:bd66:9191 with SMTP id j2-20020a056638148200b0032ebd669191mr12341644jak.134.1653590751033;
        Thu, 26 May 2022 11:45:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxh6amKbzzvb1F7KtA6vAjHtNku/3C9o4ZBn9vc2jMF1RWid75p2srSYyvZUrM76JTgJ+owew==
X-Received: by 2002:a05:6638:1482:b0:32e:bd66:9191 with SMTP id j2-20020a056638148200b0032ebd669191mr12341638jak.134.1653590750841;
        Thu, 26 May 2022 11:45:50 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id o27-20020a02cc3b000000b0032e49fcc241sm568150jap.176.2022.05.26.11.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 11:45:50 -0700 (PDT)
Date:   Thu, 26 May 2022 14:45:48 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Dunn <daviddunn@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Junaid Shahid <junaids@google.com>
Subject: Re: [PATCH v8 11/11] KVM: selftests: Cache binary stats metadata for
 duration of test
Message-ID: <Yo/K3L62VUh4vW30@xz-m1.local>
References: <20220526175408.399718-1-bgardon@google.com>
 <20220526175408.399718-12-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220526175408.399718-12-bgardon@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 05:54:08PM +0000, Ben Gardon wrote:
> In order to improve performance across multiple reads of VM stats, cache
> the stats metadata in the VM struct.
> 
> Signed-off-by: Ben Gardon <bgardon@google.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

