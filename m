Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED0757B46A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 12:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbiGTKWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 06:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiGTKWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 06:22:51 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03CA2E6B5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 03:22:49 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id r14so5839859ljp.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 03:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cl16kPyh40ICxwYY+3mYk4PE0nsaiS1gn9PGzhE1/bU=;
        b=VNOc1fHkVEdAMwt0LD7jqKlY828wWUgCTdoDe0VIXFBUwG9FSM+lhHTYYb0A4npsSi
         ZWPyzkGLzRYSsBzzOOr3pBK2Jcr8GdLj966wegpNqEVLv4BGqHWlBjrDNJlgHsG3Mf8F
         LhVjjIBS01RKVf/nbJqi23cb/bCx+GxkvTRjSrb61+CKDD4U835BrQsDk7n8msEHWHs8
         1CNc0iYX1wZ6mgGcubgLz44vy+OVlYCVvxDg8DlS4N39hKq1OSCJ6movHCN4RH15RJi8
         3HS7KsYfdPHkAZUlDF0N7Yd2PsVpo2MK37urQTSrorRVmhp993wvzSBZxG2tSAjkOOWs
         AtNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cl16kPyh40ICxwYY+3mYk4PE0nsaiS1gn9PGzhE1/bU=;
        b=w8ntV9sYdJPWC1ZvZXaSUxJaibYXhf1W1QSUPJeWODvmPjK+RNK+Ha6AAd0NjF7caO
         U1ABngMJabHcUeCPvcerb5h9HjyVfrxqHS1qEW+aIU6VwsqLUoKrxkD9fu0JbNb9XcBs
         U/2wLO3rbEznWSBv3g1MtK2L+masIfSc6TVFDDjg/8mCdVcqhOEFfyOyxJKnlBcQ+jWw
         vRI2vZdMrPMP6PpO7lPhYErKKc4a5jgKfBcGYVCT9zFmnD4r7PJ4LPcrs8L58Yy50Au2
         e6KZfFDVXNwbBXmf9aue8auEyVDK3wqmXmwtt455kDzFoSJT8wh3Eubo70SuXzD9MSjg
         3dZw==
X-Gm-Message-State: AJIora843cosq4Mjzm0mfo0FQVqz4269A49aDBa1TYYicagqAC21UP3B
        eNai/kXOkzOf4KWYxJt8xMY+UFiEfcUZlk7q3JxO/Aatmf1GwA==
X-Google-Smtp-Source: AGRyM1tt89ygqKYKQmMyMFUmgbo5GKhBWqTi0CUzHeAnr62LUH1l4K+W2EWoLfuOPUK/ozdkq9Sy3z9ixwJLhRQpziM=
X-Received: by 2002:a2e:a595:0:b0:25d:a8c6:21cc with SMTP id
 m21-20020a2ea595000000b0025da8c621ccmr9817047ljp.416.1658312568177; Wed, 20
 Jul 2022 03:22:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220704081149.16797-1-mike.leach@linaro.org> <20220704081149.16797-9-mike.leach@linaro.org>
 <ceed3c67-c9e6-787f-f668-26b57904136e@arm.com>
In-Reply-To: <ceed3c67-c9e6-787f-f668-26b57904136e@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 20 Jul 2022 11:22:37 +0100
Message-ID: <CAJ9a7VgNO43EhzC-cmxwjEVcN+CKnqoBxiwWJSS3TPC2cEd6aQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/13] perf: cs-etm: Move mapping of Trace ID and cpu
 into helper function
To:     James Clark <james.clark@arm.com>
Cc:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mathieu.poirier@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        quic_jinlmao@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James

On Tue, 19 Jul 2022 at 15:54, James Clark <james.clark@arm.com> wrote:
>
>
>
> On 04/07/2022 09:11, Mike Leach wrote:
> > The information to associate Trace ID and CPU will be changing.
> > Drivers will start outputting this as a hardware ID packet in the data
> > file and setting the value in AUXINFO to an unused value.
> >
> > To prepare for this, we only map Trace ID and CPU data from AUXINFO if the
> > header version and values are valid, and move the mapping into a
> > helper function.
> >
> > Signed-off-by: Mike Leach <mike.leach@linaro.org>
> > ---
> >  tools/perf/util/cs-etm.c | 53 +++++++++++++++++++++++++++-------------
> >  tools/perf/util/cs-etm.h | 14 +++++++++--
> >  2 files changed, 48 insertions(+), 19 deletions(-)
> >
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index 8b95fb3c4d7b..df9d67901f8d 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -193,6 +193,30 @@ int cs_etm__get_pid_fmt(u8 trace_chan_id, u64 *pid_fmt)
> >       return 0;
> >  }
> >
> > +static int cs_etm__map_trace_id(u8 trace_chan_id, u64 *cpu_metadata)
> > +{
> > +     struct int_node *inode;
> > +
> > +     /* Get an RB node for this CPU */
> > +     inode = intlist__findnew(traceid_list, trace_chan_id);
> > +
> > +     /* Something went wrong, no need to continue */
> > +     if (!inode)
> > +             return -ENOMEM;
> > +
> > +     /*
> > +      * The node for that CPU should not be taken.
> > +      * Back out if that's the case.
> > +      */
> > +     if (inode->priv)
> > +             return -EINVAL;
> > +
> > +     /* All good, associate the traceID with the metadata pointer */
> > +     inode->priv = cpu_metadata;
> > +
> > +     return 0;
> > +}
> > +
> >  void cs_etm__etmq_set_traceid_queue_timestamp(struct cs_etm_queue *etmq,
> >                                             u8 trace_chan_id)
> >  {
> > @@ -2886,7 +2910,6 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
> >  {
> >       struct perf_record_auxtrace_info *auxtrace_info = &event->auxtrace_info;
> >       struct cs_etm_auxtrace *etm = NULL;
> > -     struct int_node *inode;
> >       unsigned int pmu_type;
> >       int event_header_size = sizeof(struct perf_event_header);
> >       int info_header_size;
> > @@ -2898,6 +2921,7 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
> >       u64 *ptr, *hdr = NULL;
> >       u64 **metadata = NULL;
> >       u64 hdr_version;
> > +     u8 trace_chan_id;
> >
> >       /*
> >        * sizeof(auxtrace_info_event::type) +
> > @@ -2991,25 +3015,20 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
> >                       goto err_free_metadata;
> >               }
> >
> > -             /* Get an RB node for this CPU */
> > -             inode = intlist__findnew(traceid_list, metadata[j][trcidr_idx]);
> > -
> > -             /* Something went wrong, no need to continue */
> > -             if (!inode) {
> > -                     err = -ENOMEM;
> > -                     goto err_free_metadata;
> > -             }
> > -
> >               /*
> > -              * The node for that CPU should not be taken.
> > -              * Back out if that's the case.
> > +              * Associate a trace ID with metadata.
> > +              * Later versions of the drivers will make this association using a
> > +              * hardware ID packet in the data file, setting the value in AUXINFO to an
> > +              * invalid trace ID value. Only map here if the value is valid.
> >                */
> > -             if (inode->priv) {
> > -                     err = -EINVAL;
> > -                     goto err_free_metadata;
> > +             if (hdr_version <  CS_AUX_HW_ID_VERSION_MIN) {
> > +                     trace_chan_id = metadata[j][trcidr_idx];
> > +                     if (CS_IS_VALID_TRACE_ID(trace_chan_id)) {
> > +                             err = cs_etm__map_trace_id(trace_chan_id, metadata[j]);
> > +                             if (err)
> > +                                     goto err_free_metadata;
> > +                     }
> >               }
> > -             /* All good, associate the traceID with the metadata pointer */
> > -             inode->priv = metadata[j];
> >       }
> >
> >       /*
> > diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
> > index 90c83f932d9a..712a6f855f0e 100644
> > --- a/tools/perf/util/cs-etm.h
> > +++ b/tools/perf/util/cs-etm.h
> > @@ -28,13 +28,17 @@ enum {
> >  /*
> >   * Update the version for new format.
> >   *
> > - * New version 1 format adds a param count to the per cpu metadata.
> > + * Version 1: format adds a param count to the per cpu metadata.
> >   * This allows easy adding of new metadata parameters.
> >   * Requires that new params always added after current ones.
> >   * Also allows client reader to handle file versions that are different by
> >   * checking the number of params in the file vs the number expected.
> > + *
> > + * Version 2: Drivers will use PERF_RECORD_AUX_OUTPUT_HW_ID to output
> > + * CoreSight Trace ID. ...TRACEIDR metadata will be set to unused ID.
> >   */
> > -#define CS_HEADER_CURRENT_VERSION 1
> > +#define CS_HEADER_CURRENT_VERSION    2
> > +#define CS_AUX_HW_ID_VERSION_MIN     2
>
> Hi Mike,
>
> I'm starting to look at this set now.
>
> Am I right in thinking that this hard coded value means that new versions
> of Perf won't work with older drivers? Does this need to be highlighted
> somewhere in a warning that it's not the Perf version that's the issue but
> both the Perf and driver version together?
>

Need to differentiate here between perf record, and perf report.

My understanding is that perf record must always match the version of
your kernel. If you use an old version of perf record on a newer
kernel then you are asking for trouble.
Indeed, if I run perf on my x86 dev machine at the moment it whinges:
WARNING: perf not found for kernel 5.4.0-122
because the last version of perf I have is for 5.4.0-120.

The new perf report will differentiate between the new and old
versions of the perf.data file and act accordingly. For version 1 it
will take the IDs from the metadata, for version 2 it will search for
the IDs in the packet data.
An older perf report will not be able to decode the newer files -
though that has always been the case.

Were we to permit and old version of perf report to be used to
generate a file using the new drivers, and then attempt to process
that file with and older perf report, it would fail miserably.

Regards

Mike


> I thought the idea was to search through the file to look for
> PERF_RECORD_AUX_OUTPUT_HW_ID records (or lack of) and then choose the appropriate
> decode method. But maybe that's too complicated and there is no requirement
> for backwards compatibility?
>
> From experience it can be inconvenient when you can't just throw
> any build of Perf on a system and it supports everything that it knows
> about. Now we will have Perf builds that know about Coresight but don't
> work with older drivers.
>
> But then as you say the ID allocation is already broken for some people.
> It's hard to decide.
>
> James
>
> >
> >  /* Beginning of header common to both ETMv3 and V4 */
> >  enum {
> > @@ -85,6 +89,12 @@ enum {
> >       CS_ETE_PRIV_MAX
> >  };
> >
> > +/*
> > + * Check for valid CoreSight trace ID. If an invalid value is present in the metadata,
> > + * then IDs are present in the hardware ID packet in the data file.
> > + */
> > +#define CS_IS_VALID_TRACE_ID(id) ((id > 0) && (id < 0x70))
> > +
> >  /*
> >   * ETMv3 exception encoding number:
> >   * See Embedded Trace Macrocell specification (ARM IHI 0014Q)



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
