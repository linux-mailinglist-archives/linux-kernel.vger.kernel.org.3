Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76AB5151B9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 19:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379667AbiD2RZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 13:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379661AbiD2RZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:25:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5FB0CC8642
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 10:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651252907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qfPh0kjKV7Wz4rw1eQJIM18yZvKQM4d4G44x6rYSMsU=;
        b=Ak3wnRHLiHYnZVxdA3lHlaz7pKFMOD4jMLmbdXrVY2tgR9LUw2QidIx6lyNouLURV1TEss
        Dnb0VqA5X8Sqt+q2hxH9GoP/ffxVT8C7sQkp/AxJhH8VFZlo3UHxgrjWpo4HFdrqobP9WY
        kFrgd18gx+aPRjzhKh4dnxZYSZtbvKA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-83-dZZqh0KqMHmcIjaqKQ81kQ-1; Fri, 29 Apr 2022 13:21:46 -0400
X-MC-Unique: dZZqh0KqMHmcIjaqKQ81kQ-1
Received: by mail-pj1-f71.google.com with SMTP id gg5-20020a17090b0a0500b001d9852bd129so4339580pjb.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 10:21:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qfPh0kjKV7Wz4rw1eQJIM18yZvKQM4d4G44x6rYSMsU=;
        b=A5e3g6sb1TjjKIYbfrtQeeG0IlxkRqDnFf/64FtLtyvn8CTev+NtiOvfKnxbj06x4Y
         qwgv9Nsz8Fzk0tagseUdSwcemfzFPqHHGtC9ePf57I9s7gPd9Kttc6G9xRsMJVGSWJml
         Rx1uJMTjDSqU9NFwm/41f926uq9IlG6+GvthPi3UOrvJiCJiEiqgzTSQFNcTo38gZPUQ
         ojaf9fDfdf/aoc0BVsn89mgkDiBoQVqwezaEX94eF2mPeA1jzWJZzV83ohncEZqKEZ/q
         zR55BVOezF71522d4GynWmjgYKPYT+iTZCQ/8iDtvLWZmTAEZOdKp0o2TW8sJUbVB0De
         pJBQ==
X-Gm-Message-State: AOAM532aoFBAKpNc6hp+7sl2gxcOrb6AtQBDp+PeaM44aJ8utC56264D
        w9/xVf7joq/54dSIi+59QjMpnNBWofE/wU2bfioW5PTamXpj+ufpO5PAM+xiOWMijueGIGaFmSZ
        bJespMz5f9DRvQmZsvweZeQYtwo0dhRiDXinYuZNV
X-Received: by 2002:a17:90a:8591:b0:1b9:da10:2127 with SMTP id m17-20020a17090a859100b001b9da102127mr5054432pjn.13.1651252905188;
        Fri, 29 Apr 2022 10:21:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybgqQTGFo3aPUV0q7YyahyM+1X9q79zPVfMkdYHvLOVGnT5fGnsEfPpCBwqLhpGPFvVxVgzJb2z2I0F5oFwfY=
X-Received: by 2002:a17:90a:8591:b0:1b9:da10:2127 with SMTP id
 m17-20020a17090a859100b001b9da102127mr5054410pjn.13.1651252904923; Fri, 29
 Apr 2022 10:21:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220407195908.633003-1-pgonda@google.com> <CAFNjLiXC0AdOw5f8Ovu47D==ex7F0=WN_Ocirymz4xL=mWvC5A@mail.gmail.com>
 <CAMkAt6r-Mc_YN-gVHuCpTj4E1EmcvyYpP9jhtHo5HRHnoNJAdA@mail.gmail.com>
 <CAMkAt6r+OMPWCbV_svUyGWa0qMzjj2UEG29G6P7jb6uH6yko2w@mail.gmail.com>
 <62e9ece1-5d71-f803-3f65-2755160cf1d1@redhat.com> <CAMkAt6q6YLBfo2RceduSXTafckEehawhD4K4hUEuB4ZNqe2kKg@mail.gmail.com>
 <4c0edc90-36a1-4f4c-1923-4b20e7bdbb4c@redhat.com> <CAMkAt6oL5qi7z-eh4z7z8WBhpc=Ow6WtcJA5bDi6-aGMnz135A@mail.gmail.com>
 <CAMkAt6rmDrZfN5DbNOTsKFV57PwEnK2zxgBTCbEPeE206+5v5w@mail.gmail.com>
 <0d282be4-d612-374d-84ba-067994321bab@redhat.com> <CAMkAt6ragq4OmnX+n628Yd5pn51qFv4qV20upGR6tTvyYw3U5A@mail.gmail.com>
 <8a2c5f8c-503c-b4f0-75e7-039533c9852d@redhat.com> <CAMkAt6qAW5zFyTAqX_Az2DT2J3KROPo4u-Ak1sC0J+UTUeFfXA@mail.gmail.com>
 <4afce434-ab25-66d6-76f4-3a987f64e88e@redhat.com> <CAMkAt6o8u9=H_kjr_xyRO05J=RDFUZRiTc_Bw-FFDKEUaiyp2Q@mail.gmail.com>
In-Reply-To: <CAMkAt6o8u9=H_kjr_xyRO05J=RDFUZRiTc_Bw-FFDKEUaiyp2Q@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Fri, 29 Apr 2022 19:21:33 +0200
Message-ID: <CABgObfa0ubOwNv2Vi9ziEjHXQMR_Sa6P-fwuXfPq76qy0N61kA@mail.gmail.com>
Subject: Re: [PATCH v3] KVM: SEV: Mark nested locking of vcpu->lock
To:     Peter Gonda <pgonda@google.com>
Cc:     John Sperbeck <jsperbeck@google.com>,
        kvm list <kvm@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        Sean Christopherson <seanjc@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 7:12 PM Peter Gonda <pgonda@google.com> wrote:
> Sounds good. Instead of doing this prev_vcpu solution we could just
> keep the 1st vcpu for source and target. I think this could work since
> all the vcpu->mutex.dep_maps do not point to the same string.
>
> Lock:
>          bool acquired = false;
>          kvm_for_each_vcpu(...) {
>                  if (mutex_lock_killable_nested(&vcpu->mutex, role)
>                      goto out_unlock;
>                 acquired = true;
>                  if (acquired)
>                       mutex_release(&vcpu->mutex, role)
>          }

Almost:

          bool first = true;
          kvm_for_each_vcpu(...) {
                  if (mutex_lock_killable_nested(&vcpu->mutex, role)
                      goto out_unlock;
                  if (first)
                      ++role, first = false;
                 else
                      mutex_release(&vcpu->mutex, role);
         }

and to unlock:

          bool first = true;
          kvm_for_each_vcpu(...) {
                if (first)
                      first = false;
                else
                      mutex_acquire(&vcpu->mutex, role);
                mutex_unlock(&vcpu->mutex);
                acquired = false;
          }

because you cannot use the first vCPU's role again when locking.

Paolo

