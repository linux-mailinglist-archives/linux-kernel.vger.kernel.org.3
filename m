Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC4F577EDC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 11:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbiGRJnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 05:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbiGRJnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 05:43:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE2B61AD9A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658137378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uXsawOufScCM/h/0STmUHv9PQWBiZyHK6GMTOKvjTFs=;
        b=hGGVFVUH9SB32r9bp4RWfryyOmY2HRDjtsjRowPsI7NK/dP6MMCz9OeimqorqpgJKJ5Svg
        Yq438MvE3rVdyZDbnzJf5PbzZbnwUFU+MiQ2ZPQyLc66JLHK6FXkSae+9b8SLlUI2X1L5u
        K6a+DP94OgxmptlHzTLbonvIc3BjEZA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-495-BOkAJgwZPRmkOjXEha-gzw-1; Mon, 18 Jul 2022 05:42:57 -0400
X-MC-Unique: BOkAJgwZPRmkOjXEha-gzw-1
Received: by mail-qk1-f199.google.com with SMTP id bp14-20020a05620a458e00b006b59195c391so9056275qkb.19
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=uXsawOufScCM/h/0STmUHv9PQWBiZyHK6GMTOKvjTFs=;
        b=j8Ka27z2eENJpUL++Tir4J2rtPrTHiVdh7DxHf9an0xfXK9eyNPJblwePSh59/G8mp
         u8/Kt0iJIvIvzaXd0CoVDRIE/unr0/bGzP5x5TQ3cjw7ym9L/eyhVBxZt4v/uDTq53Vy
         XeBjK/BfVTOeju/je6y4uuZ2IVa/vgntP88bH52twkYjFIZ2SD0V7i7jFbKmZ2ecGYF3
         CRzMzqDbQd+WVxbMjXlhqCxrvjVpQUTjEcJGtMD08z5m6O7WhLUcMjcfOJvGn7LG79HC
         7P6HC8ijyikJGzE/OgwyKOQboxALNNi5UmhltjCSiQyZjxpFj8s44yzNrwBi41dOaFTA
         HxBw==
X-Gm-Message-State: AJIora8sbrUU9vAgZ7FovA7Ifi44bz++cyk7Ysve/4fXyFuF9pd8kFLw
        BcKhwqwQx3HA5IEYxG80X1h7OFulzr2ZjpXTUxO12dFguOft+ESH1cez/qqL36ZtvQ860e4j7mF
        +FfQMEbw/+ihT7zZdtMbYaW/G
X-Received: by 2002:a0c:e151:0:b0:472:ed70:5f8 with SMTP id c17-20020a0ce151000000b00472ed7005f8mr19933383qvl.99.1658137377287;
        Mon, 18 Jul 2022 02:42:57 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sxVWRgOCtS+n9Y8O3vdTv9h5Ggs4r1AGyAzDVkKxjpFYANErewut5frVji6Q1WuW63r0aXfA==
X-Received: by 2002:a0c:e151:0:b0:472:ed70:5f8 with SMTP id c17-20020a0ce151000000b00472ed7005f8mr19933370qvl.99.1658137377073;
        Mon, 18 Jul 2022 02:42:57 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id bt14-20020ac8690e000000b0031ef0081d77sm1837434qtb.79.2022.07.18.02.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 02:42:56 -0700 (PDT)
Message-ID: <298d3c2601b13bf45044e92af02a28d5440e944f.camel@redhat.com>
Subject: Re: [PATCH 1/4] KVM: x86: Reject loading KVM if host.PAT[0] != WB
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 18 Jul 2022 12:42:52 +0300
In-Reply-To: <YtH1q3C4F+LAEDTf@google.com>
References: <20220715230016.3762909-1-seanjc@google.com>
         <20220715230016.3762909-2-seanjc@google.com>
         <CALMp9eQdzZK4ZAyQZXUWff_zuRRdr=ugkujWfFrt9dP8uFcs=Q@mail.gmail.com>
         <YtH1q3C4F+LAEDTf@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-07-15 at 23:18 +0000, Sean Christopherson wrote:
> On Fri, Jul 15, 2022, Jim Mattson wrote:
> > On Fri, Jul 15, 2022 at 4:02 PM Sean Christopherson <seanjc@google.com> wrote:
> > > 
> > > Reject KVM if entry '0' in the host's IA32_PAT MSR is not programmed to
> > > writeback (WB) memtype.  KVM subtly relies on IA32_PAT entry '0' to be
> > > programmed to WB by leaving the PAT bits in shadow paging and NPT SPTEs
> > > as '0'.  If something other than WB is in PAT[0], at _best_ guests will
> > > suffer very poor performance, and at worst KVM will crash the system by
> > > breaking cache-coherency expecations (e.g. using WC for guest memory).
> > > 
> > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > ---
> > What if someone changes the host's PAT to violate this rule *after*
> > kvm is loaded?
> 
> Then KVM (and probably many other things in the kernel) is hosed.  The same argument
> (that KVM isn't paranoid enough) can likely be made for a number of MSRs and critical
> registers.
> 

I was thinking about the same thing and I also 100% agree with the above.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

