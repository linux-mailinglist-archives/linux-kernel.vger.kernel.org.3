Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8EC4C761C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 18:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237492AbiB1R7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 12:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240376AbiB1RyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 12:54:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADDEEB16F0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 09:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646070113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+pMff1CjJQQtrDDYhTBw5IeTxg6x2wxXAOITJ3SlaQg=;
        b=eV7PRb1vEJ/vXcb9yIpntLGmMO/jmrGizWHFs8EgLmpA6tHPqN00+yukZTvi7pACLSXair
        dIVjY7VRkINIVubJxlekc+jdrybIydHg2qO4W2LDt3NNWHUzPHzIq1MHGn/OGrjnOWIpja
        EQJk6AkeMnpOsxNZncE+Iq/4eux/9PY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-v0AjD8v6N4CxB-Zauq7QDQ-1; Mon, 28 Feb 2022 12:41:51 -0500
X-MC-Unique: v0AjD8v6N4CxB-Zauq7QDQ-1
Received: by mail-pl1-f199.google.com with SMTP id y3-20020a1709029b8300b0014c8bcb70a1so5120422plp.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 09:41:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+pMff1CjJQQtrDDYhTBw5IeTxg6x2wxXAOITJ3SlaQg=;
        b=YYu4Atwti6OfAQ4l+IAyobX7hIsDNr72pa/34I6kuiMijaJ3fPxlp8084oeSZAtYva
         w4kJ89SUeTV47Mg3h8ubb8VTEKGY7vFHfYlUnkkIAVrUWN/DzGgGUqGldM5pMK59B3Be
         WzGasVtTdfSh6RlwHrRUIAQY4E6y3W5bR+otCxDD/l98O1J0JwA/P0m3p6iqeofLwrr2
         dL70KuenBCS0tTMf1gPm70KLn6/Akq0I+l8wx/uIfYjXpK4pVFCV0lauXLUFgwBEz5W7
         jUMDJPIjgORHcpxP0TdZO3qgrEI+GqBhdK41vlPJ/92k08ZzIH26NZ/oSj8OvGaBnvP9
         ZloA==
X-Gm-Message-State: AOAM531/D+cIVrUt+LRvr+HMIWecEM88yVgShp4Bahs5gXRsDGyeK37O
        nPGDxo3PjZQZrgZjSV3UDPd6+k8HxymgDRFGLbP1JbFsgy6jl80GwoT7fuocY3/xgffG3KKqANq
        xGkNbwH/J17O3p2aE4wIgH023sGflBzsgD9OEYUvP
X-Received: by 2002:a05:6a00:1c4c:b0:4f4:236b:4382 with SMTP id s12-20020a056a001c4c00b004f4236b4382mr1298665pfw.29.1646070108101;
        Mon, 28 Feb 2022 09:41:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxhNSW6RN5nrKEatCvn7DkBEzajnGbEnhX4158KlrGGVvwRKbmMoUbrvuMj891xUnUhZdN02WQep+maI+2Mpfw=
X-Received: by 2002:a05:6a00:1c4c:b0:4f4:236b:4382 with SMTP id
 s12-20020a056a001c4c00b004f4236b4382mr1298642pfw.29.1646070107819; Mon, 28
 Feb 2022 09:41:47 -0800 (PST)
MIME-Version: 1.0
References: <20220224110828.2168231-1-benjamin.tissoires@redhat.com>
 <20220224110828.2168231-3-benjamin.tissoires@redhat.com> <CAPhsuW6m-HpfKLke1b7ni1j5Je3b3J0fa+MfJNnq2C9baOry1A@mail.gmail.com>
In-Reply-To: <CAPhsuW6m-HpfKLke1b7ni1j5Je3b3J0fa+MfJNnq2C9baOry1A@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 28 Feb 2022 18:41:36 +0100
Message-ID: <CAO-hwJKCEtQi-VHikw_tLxa5to0Y40KO7HSQrQtzcth_MawQ5A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/6] HID: bpf: allow to change the report
 descriptor from an eBPF program
To:     Song Liu <song@kernel.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Joe Stringer <joe@cilium.io>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2022 at 8:31 AM Song Liu <song@kernel.org> wrote:
>
> On Thu, Feb 24, 2022 at 3:09 AM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > The report descriptor is the dictionary of the HID protocol specific
> > to the given device.
> > Changing it is a common habit in the HID world, and making that feature
> > accessible from eBPF allows to fix devices without having to install a
> > new kernel.
> >
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>
> [...]
>
> > diff --git a/include/linux/hid.h b/include/linux/hid.h
> > index 8fd79011f461..66d949d10b78 100644
> > --- a/include/linux/hid.h
> > +++ b/include/linux/hid.h
> > @@ -1213,10 +1213,16 @@ do {                                                                    \
> >
> >  #ifdef CONFIG_BPF
> >  u8 *hid_bpf_raw_event(struct hid_device *hdev, u8 *rd, int *size);
> > +u8 *hid_bpf_report_fixup(struct hid_device *hdev, u8 *rdesc, unsigned int *size);
> >  int hid_bpf_module_init(void);
> >  void hid_bpf_module_exit(void);
> >  #else
> >  static inline u8 *hid_bpf_raw_event(struct hid_device *hdev, u8 *rd, int *size) { return rd; }
> > +static inline u8 *hid_bpf_report_fixup(struct hid_device *hdev, u8 *rdesc,
> > +                                      unsigned int *size)
> > +{
> > +       return kmemdup(rdesc, *size, GFP_KERNEL);
> > +}
> >  static inline int hid_bpf_module_init(void) { return 0; }
> >  static inline void hid_bpf_module_exit(void) {}
> >  #endif
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 5978b92cacd3..a7a8d9cfcf24 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -999,6 +999,7 @@ enum bpf_attach_type {
> >         BPF_SK_REUSEPORT_SELECT_OR_MIGRATE,
> >         BPF_PERF_EVENT,
> >         BPF_HID_DEVICE_EVENT,
> > +       BPF_HID_RDESC_FIXUP,
> >         __MAX_BPF_ATTACH_TYPE
> >  };
> >
> > diff --git a/include/uapi/linux/bpf_hid.h b/include/uapi/linux/bpf_hid.h
> > index 243ac45a253f..c0801d7174c3 100644
> > --- a/include/uapi/linux/bpf_hid.h
> > +++ b/include/uapi/linux/bpf_hid.h
> > @@ -18,6 +18,7 @@ struct hid_device;
> >  enum hid_bpf_event {
> >         HID_BPF_UNDEF = 0,
> >         HID_BPF_DEVICE_EVENT,
> > +       HID_BPF_RDESC_FIXUP,
> >  };
> >
> >  /* type is HID_BPF_DEVICE_EVENT */
> > @@ -26,12 +27,19 @@ struct hid_bpf_ctx_device_event {
> >         unsigned long size;
> >  };
> >
> > +/* type is HID_BPF_RDESC_FIXUP */
> > +struct hid_bpf_ctx_rdesc_fixup {
> > +       __u8 data[HID_BPF_MAX_BUFFER_SIZE];
> > +       unsigned long size;
> > +};
>
> This looks same as HID_BPF_DEVICE_EVENT, do we really need to
> separate the two?

I wanted to separate them because the other types have other requirements.

However, they all need a "data" with "size" associated. So I'll add
data and size to the common definition of the struct, leaving only the
specifics in the union (which means that DEVICE_EVENT and RDESC_FIXUP
won't have a definition in the union). I'll see the look of it before
submitting v2.

Cheers,
Benjamin

