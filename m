Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A474E1E2F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 23:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244331AbiCTWyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 18:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240816AbiCTWyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 18:54:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7A6C366A6
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 15:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647816790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lbklHsC4p2zDoA9Qm45sY9QvlkWdqqX9EtVTWkPxbLA=;
        b=TcNXjRqi/sMoz/p1eroeIlV8om0e909RmQme1L3vYD7ftn0dINAU/ouGFmIeBdqHCCsFGE
        VRsaV8Es6s2PXM/n2gSWTdphJNFWqBzZnxYmVQzF2YHJrPAij4lVc29ibYl48xVMmUj8KD
        CR2+/7q3Kna6eC9g0vB/Mh5GSrxWL9E=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-467-Guqe1j6EOSWeTwJAjrcvWQ-1; Sun, 20 Mar 2022 18:53:09 -0400
X-MC-Unique: Guqe1j6EOSWeTwJAjrcvWQ-1
Received: by mail-ej1-f72.google.com with SMTP id i14-20020a17090639ce00b006dabe6a112fso6250412eje.13
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 15:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lbklHsC4p2zDoA9Qm45sY9QvlkWdqqX9EtVTWkPxbLA=;
        b=vGzdxEo+8fKOxqKMrhYLCYSNjGyCJQcWhQcYuvNgw9eIj4kGF+Cg3h6wB3/Ybb7pXv
         PSuGzLZjVkr9HTXr7SDkRzdGV4iKfxpc0tyFfs06sU/lzt/dybFobN7nYwicf+BHIE/6
         NNQNgW9X1gRDwC3Y2V34sbM7p92X5f91T/SbrKHIjoXtRQgrY39+AxdKgCUyz9vntSYV
         AMKkPRYQbmvsxepWBauzhIvBkjbdivpNI0ldfmfXkeouVNN7kE/gdE8S+WkuNsa+tUCb
         au0IdH/7+fv8MI8998J384JwKBjP6xYMySCBzEY+M83jWOjel42B7EKxZ+Dm2U3imBGa
         EyFg==
X-Gm-Message-State: AOAM533w0LEFO7Rf2j/L6Iwv0E9T5nemhfWhrzV2DHyafgqvcoNXoQkW
        AfsZPeAMZpZgYOab3DFcySzdLWf2KzF3XqFOkL3DNPsnBhwk3qWK/J2TRl3r7bX5gwj+HUKeHyQ
        QwnCLdomE8O9FmEtik21UtR06
X-Received: by 2002:a17:907:7287:b0:6df:8f48:3f76 with SMTP id dt7-20020a170907728700b006df8f483f76mr17022721ejc.411.1647816787617;
        Sun, 20 Mar 2022 15:53:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZe9l6Up1iG5LURVWCj/AihbE5iv/oi8hjD6mxD1AXkSiAxFIFKMfPOvm35kPXKaxucLH/AQ==
X-Received: by 2002:a17:907:7287:b0:6df:8f48:3f76 with SMTP id dt7-20020a170907728700b006df8f483f76mr17022701ejc.411.1647816787435;
        Sun, 20 Mar 2022 15:53:07 -0700 (PDT)
Received: from redhat.com ([2.55.132.0])
        by smtp.gmail.com with ESMTPSA id t14-20020a170906608e00b006d1455acc62sm6300968ejj.74.2022.03.20.15.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 15:53:06 -0700 (PDT)
Date:   Sun, 20 Mar 2022 18:53:01 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Graf <graf@amazon.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        linux-hyperv@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        adrian@parity.io, Laszlo Ersek <lersek@redhat.com>,
        Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jann Horn <jannh@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        Colm MacCarthaigh <colmmacc@amazon.com>,
        Theodore Ts'o <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: propagating vmgenid outward and upward
Message-ID: <20220320185049-mutt-send-email-mst@kernel.org>
References: <Yh4+9+UpanJWAIyZ@zx2c4.com>
 <c5181fb5-38fb-f261-9de5-24655be1c749@amazon.com>
 <CAHmME9rTMDkE7UA3_wg87mrDVYps+YaHw+dZwF0EbM0zC4pQQw@mail.gmail.com>
 <47137806-9162-0f60-e830-1a3731595c8c@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47137806-9162-0f60-e830-1a3731595c8c@amazon.com>
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 12:18:04PM +0100, Alexander Graf wrote:
> I agree on the slightly racy compromise

Thought hard about this, I think I agree, and I guess as a minimum we
can start with at least the ACPI+RNG patch, right? That will already
address wireguard ...

-- 
MST

